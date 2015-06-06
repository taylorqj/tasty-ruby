class Review
  include Mongoid::Document

  field :user_id, :type => String
  field :menu_item_id, :type => String
  field :title, :type => String
  field :content, :type => String
  field :image, :type => String
  field :updated_at, :type => DateTime
  field :created_at, :type => DateTime

  belongs_to :menu_item
end
