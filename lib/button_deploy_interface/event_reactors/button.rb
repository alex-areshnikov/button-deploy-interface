module ButtonDeployInterface
  module EventReactors
    class Button
      def initialize(state_previous, state_current, interface_actor)
        @state_previous = state_previous
        @state_current = state_current
        @interface_actor = interface_actor
      end

      def react
        interface_actor.button_pressed(current_name) if was_not_pressed?
        interface_actor.button_released(previous_name) if no_longer_pressed?
      end

      private

      attr_reader :state_previous, :state_current, :interface_actor

      def was_not_pressed?
        return true if state_previous.nil?
        
        state_previous[key] == no_button_event
      end

      def no_longer_pressed?
        state_current[key] == no_button_event
      end

      def current_name
        event_name_mapping[state_current[key]]
      end

      def previous_name
        event_name_mapping[state_previous[key]]
      end

      def key
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
