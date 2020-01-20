module ButtonDeployInterface
  module EventReactors
    class Button
      def initialize(state_previous, state_current, interface_reactors)
        @state_previous = state_previous
        @state_current = state_current
        @interface_reactors = interface_reactors
      end

      def react
        return if current_name.nil? && previous_name.nil?

        interface_reactors.each do |interface_reactor|
          data = data_base.merge(name: current_name, state: :pressed) if was_not_pressed?
          data = data_base.merge(name: previous_name, state: :released) if no_longer_pressed?

          raise ButtonDeployInterface::UnexpectedButtonAction unless defined? data

          interface_reactor.call(:button, data)
        end
      end

      private

      attr_reader :state_previous, :state_current, :interface_reactors

      def data_base
        { step: step, access_granted: access_granted, finger_id: finger_id }
      end

      def was_not_pressed?
        return true if state_previous.nil?
        
        state_previous[buttons_state_key] == no_button_event
      end

      def no_longer_pressed?
        state_current[buttons_state_key] == no_button_event
      end

      def step
        state_current[ButtonDeployInterface::AwsIot::Constants::STEP_KEY]
      end

      def access_granted
        state_current[ButtonDeployInterface::AwsIot::Constants::ACCESS_GRANTED_KEY]
      end

      def finger_id
        state_current[ButtonDeployInterface::AwsIot::Constants::FINGER_ID_KEY]
      end

      def current_name
        event_name_mapping[state_current[buttons_state_key]]
      end

      def previous_name
        event_name_mapping[state_previous[buttons_state_key]]
      end

      def buttons_state_key
        ButtonDeployInterface::AwsIot::Constants::BUTTONS_STATE_KEY
      end

      def no_button_event
        ButtonDeployInterface::AwsIot::Constants::NO_BUTTON_PRESSED
      end

      def event_name_mapping
        ButtonDeployInterface::AwsIot::Constants::BUTTON_EVENT_NAME_MAPPING
      end
    end
  end
end
