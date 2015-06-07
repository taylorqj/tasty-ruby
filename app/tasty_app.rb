module Tasty
  class App
    def initialize
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        run Tasty::App.new
      end.to_app
    end

    def call(env)
      Tasty::API.call(env)
    end
  end
end
