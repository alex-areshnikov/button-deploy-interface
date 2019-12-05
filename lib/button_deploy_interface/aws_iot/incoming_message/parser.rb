module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      class Parser
        def initialize(topic, payload, interface_actor)
          @topic = topic
          @payload = payload
          @interface_actor = interface_actor
          @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new(
            ButtonDeployInterface::AwsIot::Constants::DEPLOY_BUTTON_THING_NAME)
        end

        def process
          topic_processor.new(payload, interface_actor).process
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

        attr_reader :topic, :payload, :interface_actor, :deploy_button_topics
      end
    end
  end
end
