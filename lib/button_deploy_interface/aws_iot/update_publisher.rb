module ButtonDeployInterface
  module AwsIot
    class UpdatePublisher
      def initialize(connector)
        @connector = connector
        @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new
      end

      def call(payload)
        raise ClientNotConnected unless connector.connected?

        connector.publish(deploy_button_topics.update, payload)
      end

      private

      attr_reader :connector, :deploy_button_topics
    end
  end
end
