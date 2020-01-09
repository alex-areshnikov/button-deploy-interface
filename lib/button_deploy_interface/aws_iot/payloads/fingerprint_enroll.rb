module ButtonDeployInterface
  module AwsIot
    module Payloads
      class FingerprintEnroll
        def initialize(enroll_id)
          @enroll_id = enroll_id
        end

        def call
          ButtonDeployInterface::AwsIot::Payloads::Desired.build do
            {
              fingerprint: {
                enroll: true,
                id: enroll_id
              }
            }
          end
        end

        private

        attr_reader :enroll_id
      end
    end
  end
end
