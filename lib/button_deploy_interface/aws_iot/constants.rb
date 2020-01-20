module ButtonDeployInterface
  module AwsIot
    module Constants
      AWS_IOT_ENDPOINT_URL = "a1nehtglb59qw6-ats.iot.us-west-2.amazonaws.com"
      AWS_IOT_ENDPOINT_PORT = 8883
      DEPLOY_BUTTON_THING_NAME = "DeployButton"
      TIMEOUT_SEC = 5

      STEP_KEY = "step"
      ACCESS_GRANTED_KEY = "access_granted"
      FINGER_ID_KEY = "finger_id"
      BUTTONS_STATE_KEY = "button"
      ENROLLED_KEY = "enrolled"

      BUTTON_NAMES = [
        BUTTON_UP = :up,
        BUTTON_DOWN = :down,
        BUTTON_SELECT = :select,
        BUTTON_DEPLOY = :deploy
      ].freeze

      BUTTON_EVENTS = [
        NO_BUTTON_PRESSED = "no_button_pressed",
        UP_BUTTON_PRESSED = "up_button_pressed",
        DOWN_BUTTON_PRESSED = "down_button_pressed",
        SELECT_BUTTON_PRESSED = "select_button_pressed",
        DEPLOY_BUTTON_PRESSED = "deploy_button_pressed"
      ].freeze

      PHYSICAL_BUTTON_EVENTS = [
        UP_BUTTON_PRESSED,
        DOWN_BUTTON_PRESSED,
        SELECT_BUTTON_PRESSED,
        DEPLOY_BUTTON_PRESSED
      ].freeze

      BUTTON_EVENT_NAME_MAPPING = {
        UP_BUTTON_PRESSED => BUTTON_UP,
        DOWN_BUTTON_PRESSED => BUTTON_DOWN,
        SELECT_BUTTON_PRESSED => BUTTON_SELECT,
        DEPLOY_BUTTON_PRESSED => BUTTON_DEPLOY
      }

      STEPS = [
        STEP_READY = 0,
        STEP_FINGERPRINT_SCAN = 1,
        STEP_ACCESS_GRANTED = 2,
        STEP_DEPLOYING = 3,
        STEP_ERROR = 15
      ]
    end
  end
end
