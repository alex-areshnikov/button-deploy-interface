module ButtonDeployInterface
  class Client
    def initialize(certificate_path, private_key_path)
      @connector = ButtonDeployInterface::AwsIot::Connector.new(certificate_path, private_key_path)

      @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new(
        ButtonDeployInterface::AwsIot::Constants::DEPLOY_BUTTON_THING_NAME)

      @interface_actor = ButtonDeployInterface::Actor.new
    end

    def setup
      register_incoming_messages_callback
      connector.connect
      wait_for_connected
      connector.subscribe(deploy_button_topics.update_documents)
    end

    private

    def register_incoming_messages_callback
      callback = proc do |topic, payload|        
        ButtonDeployInterface::AwsIot::IncomingMessage::Parser.new(topic, payload, interface_actor).process
      end

      connector.register_on_message_callback(callback)
    end

    def wait_for_connected
      Timeout.timeout(ButtonDeployInterface::AwsIot::Constants::TIMEOUT_SEC) do
        break if connector.connected?
        sleep(0.5)
      end
    end

    attr_reader :connector, :deploy_button_topics, :interface_actor
  end
end
