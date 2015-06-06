class Key
  include Mongoid::Document
  field :access_token, :type => String
  field :expires_at, :type => String
  field :user_id, :type => String
  field :active, :type => String

  belongs_to :user, index: true

  before_create :generate_access_token
  before_create :set_expiration

  def expired?
    DateTime.now >= self.expires_at
  end

  private
  def generate_access_token
    if !self.access_token
      self.access_token = SecureRandom.hex
    end
  end

  def set_expiration
    self.expires_at = DateTime.now + 30
  end
end