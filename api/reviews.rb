module Tasty
  class Reviews < Grape::API
    before do
      authenticate!
    end

    resource :review do
      desc 'creates a review for a menu item'
      params do
        requires :title, type: String, desc: 'title'
        requires :content, type: String, desc: 'content'
        requires :id, type: String, desc: 'menu item id'
      end
      post do
        restaurant = Restaurant.where('menus.menu_items._id' => id_parse(params[:id])).first

        not_found('Menu item not found') if restaurant.nil?

        Review.create!(
          title: params[:title],
          content: params[:content],
          menu_item_id: params[:id],
          user_id: current_user.id,
          updated_at: DateTime.now,
          created_at: DateTime.now)
      end

      desc 'update a review'
      params do
        requires :id, type: String, desc: 'id'
        requires :title, type: String, desc: 'title'
        requires :content, type: String, desc: 'content'
      end
      put do
        review = Review.find(params[:id])

        not_found('review not found') if review.nil?

        unauthorized if review.user_id != current_user.id.to_s

        review.update!(title: params[:title], content: params[:content], updated_at: DateTime.now)

        review
      end

      desc 'delete a review'
      params do
        requires :id, type: String, desc: 'id'
      end
      delete do
        review = Review.find(params[:id])

        not_found('Review not found') if review.nil?

        unauthorized if review.user_id != current_user.id.to_s

        review.destroy
      end
    end

    resource :reviews do
      desc 'get menu item with reviews'
      params do
        requires :id, type: String, desc: 'id'
      end
      get do
        restaurant = Restaurant.where('menus.menu_items._id' => id_parse(params[:id])).first

        not_found('Menu item not found') if restaurant.nil?

        # get the menu the item is located in
        menu = restaurant.menus.where('menu_items._id' => id_parse(params[:id])).first

        # get item in the menu
        item = menu.menu_items.find(params[:id])

        # return anon object
        return {
          name: item.name,
          description: item.description,
          rating: item.rating,
          reviews: item.reviews # adding reviews
        }
      end

      desc 'get all reviews'
      get '/all' do
        Review.all
      end
    end
  end
end
