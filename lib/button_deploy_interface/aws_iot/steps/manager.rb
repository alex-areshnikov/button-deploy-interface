module ButtonDeployInterface
  module AwsIot
    module Steps
      class Manager
        def initialize(connector)
          @connector = connector
          @current_step = ButtonDeployInterface::AwsIot::Constants::STEP_READY
          @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new
        end

        def set_step(step)
          raise ClientNotConnected unless connector.connected?

          payload = ButtonDeployInterface::AwsIot::Steps::Composer.new(step).call
          connector.publish(@deploy_button_topics.update, payload)

          @current_step = step
        end

        private

        attr_reader :connector
      end
    end
  end
end
