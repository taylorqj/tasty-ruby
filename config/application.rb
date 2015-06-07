$:.unshift File.join(File.dirname(__FILE__), '..', 'api')
$:.unshift File.join(File.dirname(__FILE__), '..', 'app')
$:.unshift File.dirname(__FILE__)

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

# load figaro environment
Figaro.application = Figaro::Application.new(environment: ENV['RACK_ENV'], path: "config/application.yml")
Figaro.load

# require and load mongo
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

# require all api routes
Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

# application setup
require 'api'
require 'tasty_app'

# oid to pretty json
module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json
    end

    def as_json(*args)
      to_s.as_json
    end
  end
end
