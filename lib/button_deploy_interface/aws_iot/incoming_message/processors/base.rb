module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      module Processors
        class Base
          def initialize(message, interface_reactors)
            @message_raw = message
            @interface_reactors = interface_reactors
          end

          def process
            raise ButtonDeployInterface::UnrecognizedMessage
          end

          private

          attr_reader :state, :interface_reactors

          def message
            @message ||= JSON.parse(@message_raw)
          end
        end
      end
    end
  end
end
