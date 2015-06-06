module Tasty
  module Helpers
    module UserHelpers
      def sanitize_many(users)
        users.map do |u|
          User.new(
            id: u.id,
            email: u.email,
            first_name: u.first_name,
            last_name: u.last_name,
            follower_ids: u.follower_ids,
            following_ids: u.following_ids)
        end
      end

      def sanitize_one(user)
        User.new(
          id: user.id,
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name,
          follower_ids: user.follower_ids,
          following_ids: user.following_ids)
      end
    end
  end
end
