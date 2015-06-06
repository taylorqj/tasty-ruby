class Restaurant
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  geocoded_by :address

  field :name, :type => String
  field :description, :type => String
  field :website, :type => String
  field :phone, :type => String
  field :coordinates, :type => Array

  field :street, :type => String
  field :city, :type => String
  field :state, :type => String
  field :country, :type => String

  embeds_many :menus

  after_validation :geocode

  def address
    [street, city, state, country].compact.join(', ')
  end
end