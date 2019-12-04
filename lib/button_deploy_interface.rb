Dir["#{File.dirname(__FILE__)}/button_deploy_interface/**/*.rb"].each { |f| load(f) }

require "paho-mqtt"
require "timeout"

module ButtonDeployInterface
  class Error < StandardError; end
  # Your code goes here...
end
