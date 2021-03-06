module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      class Parser
        def initialize(topic, payload, interface_reactors)
          @topic = topic
          @payload = payload
          @interface_reactors = interface_reactors
          @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new
        end

        def process
          topic_processor.new(payload, interface_reactors).process
        end

        private

        def topic_processor
          {
            deploy_button_topics.get_rejected => ButtonDeployInterface::AwsIot::IncomingMessage::Processors::GetRejected,
            deploy_button_topics.update_documents => ButtonDeployInterface::AwsIot::IncomingMessage::Processors::UpdateDocuments,
            deploy_button_topics.update_rejected => ButtonDeployInterface::AwsIot::IncomingMessage::Processors::UpdateRejected,
            deploy_button_topics.delete_rejected => ButtonDeployInterface::AwsIot::IncomingMessage::Processors::DeleteRejected
          }.fetch(topic, ButtonDeployInterface::AwsIot::IncomingMessage::Processors::Base)
        end

        attr_reader :topic, :payload, :interface_reactors, :deploy_button_topics
      end
    end
  end
end
