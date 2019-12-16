module ButtonDeployInterface
  module AwsIot
    module Steps
      class Composer
        def initialize(step)
          @step = step
        end

        def call
          {
            state: {
              desired: {
                step: step
              }
            }
          }.to_json
        end

        private

        attr_reader :step
      end
    end
  end
end
