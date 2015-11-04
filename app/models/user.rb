class User < ActiveRecord::Base

  # Validates
  validates :name, presence: true, length: { maximum: 50 }

  # Expression email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true

  # fix element before save
  before_save {
    self.email = email.downcase
  }
  
end
