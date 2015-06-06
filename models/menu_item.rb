class MenuItem
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :rating, :type => Integer

  has_many :reviews
  embedded_in :menu
end
