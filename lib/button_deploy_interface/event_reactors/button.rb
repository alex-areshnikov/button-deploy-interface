module ButtonDeployInterface
  module EventReactors
    class Button
      def initialize(state_previous, state_current, interface_reactors)
        @state_previous = state_previous
        @state_current = state_current
        @interface_reactors = interface_reactors
      end

      def react
        interface_reactors.each do |interface_reactor|
          data = { name: current_name, state: :pressed, step: step } if was_not_pressed?
          data = { name: previous_name, state: :released, step: step } if no_longer_pressed?

          raise ButtonDeployInterface::UnexpectedButtonAction unless defined? data
          return if data[:name].nil?

          interface_reactor.call(:button, data)
        end
      end

      private

      attr_reader :state_previous, :state_current, :interface_reactors

      def was_not_pressed?
        return true if state_previous.nil?
        
        state_previous[key] == no_button_event
      end

      def no_longer_pressed?
        state_current[key] == no_button_event
      end

      def step
        state_current[ButtonDeployInterface::AwsIot::Constants::STEP_KEY]
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
