class User < ApplicationRecord
	attr_accessor :remember_token

	before_create :set_token
  before_save { self.email = email.downcase }
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def set_token
  	self.remember_token = generate_token
  	self.remember_digest = Digest::SHA1.hexdigest(remember_token)
  end

  def remember
    self.remember_token = generate_token
    # updates a single attribute & saves record (doesn't validate):
    # https://apidock.com/rails/ActiveRecord/Persistence/update_attribute
    update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token))
  end

  def authenticated?(token)
    return false if remember_digest.nil?
    self.remember_digest == Digest::SHA1.hexdigest(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end


