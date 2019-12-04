module ButtonDeployInterface
  module AwsIot
    class Connector
      def initialize(certificate_path:, private_key_path:)
        @certificate_path = certificate_path
        @private_key_path = private_key_path
        @mqtt_client = PahoMqtt::Client.new
        @is_connected = false
      end

      def connect
        return if connected?

        mqtt_client.ssl = true
        mqtt_client.config_ssl_context(certificate_path, private_key_path)
        mqtt_client.on_connack = proc { @is_connected = true }
        mqtt_client.on_suback { puts "Subscribed" }

        mqtt_client.on_message do |message|
          puts "Message recieved on topic: #{message.topic}\n>>> #{message.payload}"
        end

        mqtt_client.connect(ButtonDeployInterface::AwsIot::Constants::AWS_IOT_ENDPOINT_URL,
                            ButtonDeployInterface::AwsIot::Constants::AWS_IOT_ENDPOINT_PORT)
      end

      def connected?
        is_connected
      end

      def subscribe(topic, qos=0)
        mqtt_client.subscribe([topic, qos])
      end

      def publish(topic, payload)
        mqtt_client.publish(topic, payload)
      end

      private

      attr_reader :certificate_path, :private_key_path, :mqtt_client, :is_connected
    end
  end
end
