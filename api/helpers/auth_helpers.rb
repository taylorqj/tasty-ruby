module Tasty
  module Helpers
    module AuthHelpers
      extend Grape::API::Helpers

      def email_taken?(email)
        if User.where(email: email).first
          unauthorized('Email already exists.')
        else
          nil
        end
      end

      def authenticate!
        unauthorized('Unauthorized, bitch.') unless current_user
      end

      def current_user
        auth_token = headers['X-Api-Key']
        record = Key.where(access_token: auth_token).first

        if record && !record.expired?
          @current_user = User.where(id: record[:user_id]).first
        else
          false
        end
      end
    end
  end
end
