module Tasty
  module Helpers
    module ResponseHelpers
      # extend grapes built in helpers for error handling
      extend Grape::API::Helpers

      def created(message, status = 201)
        { type: 'success', message: message, status: status }
      end

      def bad_request(message, status = 400)
        error!(message, status)
      end

      def not_found(message, status = 404)
        error!(message, status)
      end

      def unauthorized(message = 'unauthorized', status = 401)
        error!(message, status)
      end
    end
  end
end
