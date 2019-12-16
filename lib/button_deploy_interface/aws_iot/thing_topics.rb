module ButtonDeployInterface
  module AwsIot
    class ThingTopics
      def initialize(thing_name=ButtonDeployInterface::AwsIot::Constants::DEPLOY_BUTTON_THING_NAME)
        @thing_name = thing_name
      end

      def update
        "$aws/things/#{thing_name}/shadow/update"
      end

      def update_accepted
        "$aws/things/#{thing_name}/shadow/update/accepted"
      end

      def update_documents
        "$aws/things/#{thing_name}/shadow/update/documents"
      end

      def update_rejected
        "$aws/things/#{thing_name}/shadow/update/rejected"
      end

      def get
        "$aws/things/#{thing_name}/shadow/get"
      end

      def get_accepted
        "$aws/things/#{thing_name}/shadow/get/accepted"
      end

      def get_rejected
        "$aws/things/#{thing_name}/shadow/get/rejected"
      end

      def delete
        "$aws/things/#{thing_name}/shadow/delete"
      end

      def delete_accepted
        "$aws/things/#{thing_name}/shadow/delete/accepted"
      end

      def delete_rejected
        "$aws/things/#{thing_name}/shadow/delete/rejected"
      end

      private

      attr_reader :thing_name
    end
  end
end
