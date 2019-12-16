Dir["#{File.dirname(__FILE__)}/button_deploy_interface/**/*.rb"].each { |f| load(f) }

require "awesome_print"
require "paho-mqtt"
require "timeout"
require "json"

module ButtonDeployInterface
  class ClientNotConnected < StandardError; end
  class UnexpectedButtonAction < StandardError; end
  class UnrecognizedMessage < StandardError; end

  class InvalidReactor < StandardError
    def initialize(msg="Reactor must be a Proc or respond to call")
      super
    end
  end
end
