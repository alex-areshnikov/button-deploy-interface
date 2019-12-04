module ButtonDeployInterface
  class Client
    def initialize(certificate_path:, private_key_path:)
      @connector = ButtonDeployInterface::AwsIot::Connector.new(
        certificate_path: certificate_path, private_key_path: private_key_path)

      @thing_topics = ButtonDeployInterface::AwsIot::ThingTopics.new(
        thing_name: ButtonDeployInterface::AwsIot::Constants::DEPLOY_BUTTON_THING_NAME)
    end

    def setup
      connector.connect
      wait_for_connected
      connector.subscribe(thing_topics.update_documents)
    end

    private

    def wait_for_connected
      Timeout.timeout(ButtonDeployInterface::AwsIot::Constants::TIMEOUT_SEC) do
        break if connector.connected?
        sleep(0.5)
      end
    end

    attr_reader :connector, :thing_topics
  end
end
