require 'airborne'

# setup application
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

# setup airborne
Airborne.configure do |config|
  config.rack_app = Tasty::App.instance
end
