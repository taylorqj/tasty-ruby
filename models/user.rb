class User
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :password_hash, :type => String
  field :password_salt, :type => String

  has_one :key

  has_and_belongs_to_many :following, :class_name => 'User', inverse_of: :followers, autosave: true
  has_and_belongs_to_many :followers, :class_name => 'User', inverse_of: :following

  attr_accessor :password

  before_save :encrypt_password

  validates_presence_of :password, :on => :login
  validates_presence_of :password, :on => :register
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = User.where(email: email).first

    if user && user[:password_hash] == BCrypt::Engine.hash_secret(password, user[:password_salt])
      user
    else
      nil
    end
  end

  def follow(user)
    if self.id != user.id && !self.following.include?(user)
      self.following << user
    end
  end

  def unfollow(user)
    self.following.delete(user)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
