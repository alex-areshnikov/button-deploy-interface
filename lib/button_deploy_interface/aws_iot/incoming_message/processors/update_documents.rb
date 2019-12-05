module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      module Processors
        class UpdateDocuments < ButtonDeployInterface::AwsIot::IncomingMessage::Processors::Base
          def process
            ButtonDeployInterface::EventReactors::Button.new(previous_state, current_state, interface_actor).react
            # TODO: ButtonDeployInterface::EventReactors::Fingerprint
          end

          private

          def previous_state
            message["previous"]["state"]["reported"]
          end

          def current_state
            message["current"]["state"]["reported"]
          end
        end
      end
    end
  end
end
