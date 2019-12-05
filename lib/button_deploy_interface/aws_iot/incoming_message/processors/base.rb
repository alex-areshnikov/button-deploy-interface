module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      module Processors
        class Base
          def initialize(message, interface_actor)
            @message_raw = message
            @interface_actor = interface_actor
          end

          def process
            raise ButtonDeployInterface::UnrecognizedMessage
          end

          private

          attr_reader :state, :interface_actor

          def message
            @message ||= JSON.parse(@message_raw)
          end
        end
      end
    end
  end
end
