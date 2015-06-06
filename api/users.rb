module Tasty
  class Users < Grape::API
    resource :users do
      desc 'returns all users'
      get '/all' do
        authenticate!
        sanitize_many(User.all)
      end

      desc 'returns single user'
      params do
        requires :id, type: String, desc: 'User Id'
      end
      get do
        authenticate!
        user = User.find(params[:id])

        not_found('User not found') if user.blank?

        sanitize_one(user)
      end

      desc 'update a user'
      params do
        requires :id, type: String, desc: 'User Id'
        requires :first_name, type: String, desc: 'First Name'
        requires :last_name, type: String, desc: 'Last Name'
      end
      put do
        authenticate!

        unauthorized('Invalid user.') if params[:id] != current_user.id.to_s

        user = User.find(params[:id])

        not_found('User not found') if user.blank?

        user.update(first_name: params[:first_name], last_name: params[:last_name])

        sanitize_one(user)
      end

      desc 'delete current user'
      params do
        requires :id, type: String, desc: 'User Id'
      end
      delete do
        authenticate!

        unauthorized('Invalid user.') if params[:id] != current_user.id.to_s

        User.find(params[:id]).destroy
      end

      desc 'follow a user'
      params do
        requires :id, type: String, desc: 'User id'
      end
      post '/follow' do
        authenticate!

        user = User.find(params[:id])

        if current_user.follow(user)
          sanitize_one(user)
        else
          not_found('Unable to follow user.')
        end
      end

      desc 'unfollow a user'
      params do
        requires :id, type: String, desc: 'User id'
      end
      delete '/unfollow' do
        authenticate!

        user = User.find(params[:id])

        if current_user.unfollow(user)
          sanitize_one(user)
        else
          not_found('Unable to unfollow user.')
        end
      end
    end
  end
end
