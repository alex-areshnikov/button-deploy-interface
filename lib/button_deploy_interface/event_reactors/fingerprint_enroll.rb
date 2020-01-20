module ButtonDeployInterface
  module EventReactors
    class FingerprintEnroll
      def initialize(state_previous, state_current, interface_reactors)
        @state_previous = state_previous
        @state_current = state_current
        @interface_reactors = interface_reactors
      end

      def react
        return unless enrolled

        interface_reactors.each do |interface_reactor|
          interface_reactor.call(:fingerprint_enroll, { finger_id: finger_id })
        end
      end

      private

      attr_reader :state_previous, :state_current, :interface_reactors

      def enrolled
        state_current[ButtonDeployInterface::AwsIot::Constants::ENROLLED_KEY]
      end

      def finger_id
        state_current[ButtonDeployInterface::AwsIot::Constants::FINGER_ID_KEY]
      end
    end
  end
end
