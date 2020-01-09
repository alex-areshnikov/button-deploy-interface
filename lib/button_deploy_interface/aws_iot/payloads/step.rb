module ButtonDeployInterface
  module AwsIot
    module Payloads
      class Step
        def initialize(step, error: false)
          @step = step
          @error = error
        end

        def call
          ButtonDeployInterface::AwsIot::Payloads::Desired.build do
            {
              step: step,
              error: error
            }
          end
        end

        private

        attr_reader :step, :error
      end
    end
  end
end
