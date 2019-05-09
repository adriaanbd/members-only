class User < ApplicationRecord
	# attr_accessor :remember_token

	before_create :set_token
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
  has_secure_password

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def generate_token
    SecureRandom.urlsafe_base64.to_s
  end

  def set_token
  	self.remember_digest = Digest::SHA1.hexdigest(generate_token)
  end

  # def remember
  #   self.remember_token = User.new_token.to_s
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end
end
