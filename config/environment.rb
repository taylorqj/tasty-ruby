# look for environment or set to default
ENV['RACK_ENV'] ||= 'default'

# require application setup
require File.expand_path('../application', __FILE__)
