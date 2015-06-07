module Tasty
  module Helpers
    module MongoHelpers
      # returns object id from string
      def id_parse(string)
        return BSON::ObjectId.from_string(string)
      end
    end
  end
end
