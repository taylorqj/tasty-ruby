module Tasty
  class MenuItems < Grape::API
    before do
      authenticate!
    end

    resource :items do
      desc 'get single menu item'
      params do
        requires :id, type: String, desc: 'menu item id'
      end
      get do
        restaurant = Restaurant.where('menus.menu_items._id' => BSON::ObjectId.from_string(params[:id])).first

        not_found('Menu item not found') if restaurant.nil?

        # get menu where item is located
        menu = restaurant.menus.where('menu_items._id' => BSON::ObjectId.from_string(params[:id])).first

        # get item
        menu.menu_items.find(params[:id])
      end

      desc 'get all menu items by menu'
      params do
        requires :id, type: String, desc: 'menu id'
      end
      get '/all' do
        restaurant = Restaurant.where('menus._id' => BSON::ObjectId.from_string(params[:id])).first

        not_found('Menu not found') if restaurant.nil?

        restaurant.menus.find(params[:id]).menu_items
      end

      desc 'create a menu item'
      params do
        requires :name, type: String, desc: 'name'
        requires :description, type: String, desc: 'description'
        requires :id, type: String, desc: 'menu id'
      end
      post do
        restaurant = Restaurant.where('menus._id' => BSON::ObjectId.from_string(params[:id])).first

        not_found('Menu not found') if restaurant.nil?

        # get menu
        menu = restaurant.menus.find(params[:id])

        # create a new menu item
        item = MenuItem.new(name: params[:name], description: params[:description])

        menu.menu_items.push(item)
        menu.menu_items.find(item.id)
      end

      desc 'update menu item'
      params do
        requires :id, type: String, desc: 'menu item id'
        requires :name, type: String, desc: 'name'
        requires :description, type: String, desc: 'description'
      end
      put do
        restaurant = Restaurant.where('menus.menu_items._id' => BSON::ObjectId.from_string(params[:id])).first

        not_found('Menu item not found') if restaurant.nil?

        # get the menu the item is located in
        menu = restaurant.menus.where('menu_items._id' => BSON::ObjectId.from_string(params[:id])).first

        # get the item
        item = menu.menu_items.find(params[:id])

        # update
        item.update(name: params[:name], description: params[:description])

        # return item
        item
      end
    end
  end
end
