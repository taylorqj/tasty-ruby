$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

#load up mongo
require 'mongoid'
Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'])

# require all models
Dir[File.expand_path('../../models/*.rb', __FILE__)].each do |f|
  require f
end

# require all helpers
Dir[File.expand_path('../../api/helpers/*.rb', __FILE__)].each do |f|
  require f
end

# require all api classes
Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

require 'api'
require 'tasty_app'
