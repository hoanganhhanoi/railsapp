class User < ActiveRecord::Base

  has_many :microposts, dependent: :destroy
  # avaiable remember_token
  attr_accessor :remember_token, :activation_token, :reset_token

  # Validates
  validates :name, presence: true, length: { maximum: 50 }

  # Expression email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }


  # fix element before save
  before_save :downcase_email
  before_create :create_activation_digest



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
  def authenticated?(attribute, token)
    # if remember_digest is nil return false
    digest = send("#{attribute}_digest")
    if digest.nil?
      return false
    else
      BCrypt::Password.new(digest).is_password?(token)
    end
  end

  # Forget user when user log out
  def forget_user
    update_attribute(:remember_digest, nil)
  end

  # 
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token) 
  end

  # convert email
  def downcase_email
    self.email = email.downcase
  end

  # Active account
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_ata, Time.zone.now)
  end

  # Send email activation 
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Set password 
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Send password reset 
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

end
