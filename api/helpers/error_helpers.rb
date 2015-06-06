module Tasty
  module Helpers
    module ErrorHelpers
      def self.call(message, _backtrace, _options, _env)
        { type: 'error', message: message }.to_json
      end
    end
  end
end
