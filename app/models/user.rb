class User < ActiveRecord::Base
  # avaiable remember_token
  attr_accessor :remember_token

  # Validates
  validates :name, presence: true, length: { maximum: 50 }

  # Expression email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  # fix element before save
  before_save {
    self.email = email.downcase
  }

  # secure password
  has_secure_password
  validates :password, length: { minimum: 6 }

  # List function of ModelUser

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return hash digest 
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    return BCrypt::Password.create(string, cost: cost)
  end

  # Return a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Return true if token match digest
  def authenticated?(remember_token)
    # if remember_digest is nil return false
    if remember_digest.nil?
      return false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  # Forget user when user log out
  def forget_user
    update_attribute(:remember_digest, nil)
  end

end
