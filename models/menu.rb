class Menu
  include Mongoid::Document

  field :name, :type => String

  embedded_in :restaurant
  embeds_many :menu_items
end
