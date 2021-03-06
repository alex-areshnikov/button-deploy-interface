require 'forwardable'

module ButtonDeployInterface
  class Client
    extend Forwardable

    def_delegators :steps_manager, :step
    def_delegators :connector, :connection_state

    def initialize(certificate_path, private_key_path)
      @connector = ButtonDeployInterface::AwsIot::Connector.new(certificate_path, private_key_path)
      @deploy_button_topics = ButtonDeployInterface::AwsIot::ThingTopics.new
      @update_publisher = ButtonDeployInterface::AwsIot::UpdatePublisher.new(connector)
      @steps_manager = ButtonDeployInterface::AwsIot::Steps::Manager.new(update_publisher)

      @interface_reactors = []
    end

    def setup
      register_incoming_messages_callback
      connector.connect
      wait_for_connected
      connector.subscribe(deploy_button_topics.update_documents)
    end

    def register_device_action_reactor(reactor)
      raise ButtonDeployInterface::InvalidReactor unless reactor.respond_to?(:call)

      @interface_reactors << reactor
    end

    def fingerprint_enroll(enroll_id)
      payload = ButtonDeployInterface::AwsIot::Payloads::FingerprintEnroll.new(enroll_id).call
      update_publisher.call(payload)
    end

    private

    def register_incoming_messages_callback
      callback = proc do |topic, payload|
        ButtonDeployInterface::AwsIot::IncomingMessage::Parser.new(topic, payload, interface_reactors).process
      end

      connector.register_on_message_callback(callback)
    end

    def wait_for_connected
      Timeout.timeout(ButtonDeployInterface::AwsIot::Constants::TIMEOUT_SEC) do
        break if connector.connected?
        sleep(0.5)
      end
    end

    attr_reader :connector, :update_publisher, :deploy_button_topics, :interface_reactors, :steps_manager
  end
end
