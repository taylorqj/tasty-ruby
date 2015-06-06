module Tasty
  class Restaurants < Grape::API

    get 'test' do
      { test: 'ok' }
    end
    # before do
    #   authenticate!
    # end

    resource :restaurants do
      desc 'create a restaurant'
      params do
        requires :name, type: String, desc: 'Restaurant name'
        requires :street, type: String, desc: 'Street address'
        requires :city, type: String, desc: 'City'
        requires :state, type: String, desc: 'State'
        requires :country, type: String, desc: 'Country'
      end
      post do
        Restaurant.create!(
          name: params[:name],
          street: params[:street],
          city: params[:city],
          state: params[:state],
          country: params[:country])
      end

      desc 'find by location'
      params do
        requires :radius, type: Float, desc: 'Radius'
        requires :address, type: String, desc: 'Address'
      end
      get '/location' do
        Restaurant.near(params[:address], params[:radius])
      end

      desc 'update a restaurant'
      params do
        requires :id, type: String, desc: 'Restaurant Id'
        requires :name, type: String, desc: 'Restaurant name'
        requires :street, type: String, desc: 'Street address'
        requires :city, type: String, desc: 'City'
        requires :state, type: String, desc: 'State'
        requires :country, type: String, desc: 'Country'
      end
      put do
        restaurant = Restaurant.find(params[:id])

        not_found('Restaurant not found') if restaurant.nil?

        restaurant.update(name: params[:name],
                          street: params[:street],
                          city: params[:city],
                          state: params[:state],
                          country: params[:country])

        restaurant
      end

      desc 'delete a restaurant'
      params do
        requires :id, type: String, desc: 'Restaurant Id'
      end
      delete do
        restaurant = Restaurant.find(params[:id])

        not_found('Restaurant not found') if restaurant.nil?

        restaurant.destroy
      end

      desc 'get restaurant by id'
      params do
        requires :id, type: String, desc: 'Restaurant id'
      end
      get do
        restaurant = Restaurant.find(params[:id])

        not_found('Restaurant not found') if restaurant.nil?

        restaurant
      end
    end
  end
end
