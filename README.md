[![Build Status](https://travis-ci.com/alex-areshnikov/button-deploy-interface.svg?branch=master)](https://travis-ci.com/alex-areshnikov/button-deploy-interface)

# ButtonDeployInterface

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/button_deploy_interface`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'button_deploy_interface'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install button_deploy_interface

## Usage

Here is a snippet that shows how to use button-deploy-interface gem

```ruby
# certificate and PK can be found at AWS IoT DeployButton thing
certificate_path = "path/to/certificate.pem.crt"
private_key_path = "path/to/private.pem.key"

# Initialize interface instance
client = ButtonDeployInterface::Client.new(certificate_path, private_key_path)

# Perform setup
client.setup

# Define a reactor
#
# Every time an action happens at the device, the reactor will be executed.
# type: type of action happened. Existing types: [:button, :fingerprint_enroll]
# data: supporting data
reactor = proc { |type, data| puts "Type: #{type} Data: #{data}"}

# Register the reactor. It is possible to register multiple reactors
client.register_device_action_reactor(reactor)

# Below described interactions with the device

# Set step. Available steps 0-14
client.step(5)

# Set erred step if something goes wrong
client.step(7, error: true)

# Enroll middle finger
# Passed parameter is the finger id to enroll. Existing finger will be overrided.
# After successfull enroll, the registered reactor(s) will be triggered with type :fingerprint_enroll and 
# supporting data will contain enrolled finger id
client.fingerprint_enroll(4)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alex-areshnikov/button-deploy-interface.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
