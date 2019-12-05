module ButtonDeployInterface
  module AwsIot
    module IncomingMessage
      module Processors
        class DeleteRejected < ButtonDeployInterface::AwsIot::IncomingMessage::Processors::Base
          def process
            raise NotImplementedError
          end
        end
      end
    end
  end
end
