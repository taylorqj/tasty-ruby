module Tasty
  class API < Grape::API
    prefix 'api'
    format :json

    # Help with authentication and authorization checks
    helpers ::Tasty::Helpers::AuthHelpers

    # Help with sanitizing sensitive data
    helpers ::Tasty::Helpers::UserHelpers

    # Handle typical responses, 404, 401, etc
    helpers ::Tasty::Helpers::ResponseHelpers

    # Handle error formatting of responses
    error_formatter :json, ::Tasty::Helpers::ErrorHelpers

    mount ::Tasty::Menus
    mount ::Tasty::MenuItems
    mount ::Tasty::Auth
    mount ::Tasty::Restaurants
    mount ::Tasty::Reviews
    mount ::Tasty::Users
  end
end
