module Tasty
  class Menus < Grape::API
    before do
      authenticate!
    end

    resource :menu do
      desc 'get menu of a restaurant'
      params do
        requires :id, type: String, desc: 'Menu id'
      end
      get do
        restaurant = Restaurant.where('menus._id' => id_parse(params[:id])).first

        not_found('Menu not found') if restaurant.nil?

        restaurant.menus.find(params[:id])
      end

      desc 'create menu'
      params do
        requires :restaurant_id, type: String, desc: 'Restaurant id'
        requires :name, type: String, desc: 'Menu name'
      end
      post do
        restaurant = Restaurant.find(params[:restaurant_id])

        not_found('Restaurant not found') if restaurant.nil?

        menu = Menu.new(name: params[:name])

        restaurant.menus.push(menu)
        restaurant.menus.find(menu.id)
      end

      desc 'update menu'
      params do
        requires :id, type: String, desc: 'Menu id'
        requires :name, type: String, desc: 'Name of menu'
      end
      put do
        restaurant = Restaurant.where('menus._id' => id_parse(params[:id])).first

        not_found('Restaurant not found') if restaurant.nil?

        # get single menu from restaurant
        menu = restaurant.menus.find(params[:id])

        # update name of menu
        menu.name = params[:name]

        # save restaurant
        restaurant.save

        # return menu
        menu
      end
    end

    resource :menus do
      desc 'get all menus of a restaurant'
      params do
        requires :id, type: String, desc: 'Restaurant id'
      end
      get do
        restaurant = Restaurant.find(params[:id])

        not_found('Restaurant not found') if restaurant.nil?

        restaurant.menus.all
      end
    end
  end
end
