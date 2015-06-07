module Tasty
  class Auth < Grape::API
    resource :auth do
      
      desc 'Authenticates and logs in a user'
      params do
        requires :email, type: String, desc: 'Email address'
        requires :password, type: String, desc: 'Password'
      end
      post :login do
        user = User.where(email: params[:email].downcase).first

        if user && User.authenticate(params[:email], params[:password])
          key = Key.create(user_id: user.id)
          { token: key[:access_token] }
        else
          unauthorized('Username or password invalid')
        end
      end

      desc 'Registers a new user'
      params do
        requires :email, type: String, desc: 'Email address'
        requires :password, type: String, desc: 'Password'
      end
      post :register do
        email_taken?(params[:email])

        user = User.create!(
          email: params[:email],
          password: params[:password],
          first_name: params[:first_name],
          last_name: params[:last_name])

        if user.save
          created('Success! Please login.')
        else
          unauthorized('Unable to register. Please try again.')
        end
      end
    end
  end
end
