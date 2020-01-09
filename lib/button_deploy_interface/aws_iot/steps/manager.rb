module ButtonDeployInterface
  module AwsIot
    module Steps
      class Manager
        def initialize(publisher)
          @publisher = publisher
          @current_step = ButtonDeployInterface::AwsIot::Constants::STEP_READY
        end

        def step(step, error: false)
          payload = ButtonDeployInterface::AwsIot::Payloads::Step.new(step, error).call
          publisher.call(payload)

          @current_step = step
        end

        private

        attr_reader :publisher
      end
    end
  end
end
