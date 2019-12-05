Dir["#{File.dirname(__FILE__)}/button_deploy_interface/**/*.rb"].each { |f| load(f) }

require "awesome_print"
require "paho-mqtt"
require "timeout"
require "json"

module ButtonDeployInterface
  class UnrecognizedMessage < StandardError; end
end
