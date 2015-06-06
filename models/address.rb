class Address
  include Mongoid::Document

  field :name, :type => String
  field :line1, :type => String
  field :line2, :type => String
  field :city, :type => String
  field :state, :type => String
  field :country, :type => String
  field :postal_code, :type => String
end