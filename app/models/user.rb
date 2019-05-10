class User < ApplicationRecord
	attr_accessor :remember_token

	before_create :remember
  before_save { self.email = email.downcase }
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      # activemodel/lib/active_model/secure_password.rb
      # SecurePassword.min_cost is false by default
      cost = BCrypt::Engine::MIN_COST if ActiveModel::SecurePassword.min_cost
      cost ||= BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    # updates a single attribute & saves record (doesn't validate):
    # https://apidock.com/rails/ActiveRecord/Persistence/update_attribute
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
