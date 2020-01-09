module ButtonDeployInterface
  module AwsIot
    module Payloads
      class Desired
        def self.build
          body = yield
          payload = { state: { } }
          payload[:state][:desired] = body

          payload.to_json
        end
      end
    end
  end
end
