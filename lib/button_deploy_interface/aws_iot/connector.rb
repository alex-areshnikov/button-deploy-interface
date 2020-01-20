require 'forwardable'

module ButtonDeployInterface
  module AwsIot
    class Connector
      extend Forwardable

      def_delegators :mqtt_client, :connection_state

      def initialize(certificate_path, private_key_path)
        @certificate_path = certificate_path
        @private_key_path = private_key_path
        @mqtt_client = PahoMqtt::Client.new(persistent: true)
        @is_connected = false
      end

      def connect
        return if connected?

        mqtt_client.ssl = true
        mqtt_client.config_ssl_context(certificate_path, private_key_path)
        mqtt_client.on_connack = proc { @is_connected = true }
        mqtt_client.on_suback { puts "Subscribed" }

        mqtt_client.connect(ButtonDeployInterface::AwsIot::Constants::AWS_IOT_ENDPOINT_URL,
                            ButtonDeployInterface::AwsIot::Constants::AWS_IOT_ENDPOINT_PORT)
      end

      def register_on_message_callback(callback)
        mqtt_client.on_message { |message| callback.call(message.topic, message.payload) }
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
