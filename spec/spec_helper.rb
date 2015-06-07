# require our testing suite
require 'airborne'

# setup application
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

# setup airborne
Airborne.configure do |config|
  config.rack_app = Tasty::App.instance
  config.headers = { 'X-Api-Key' => Figaro.env.test_key }
end
