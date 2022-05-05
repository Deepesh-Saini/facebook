class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp, message: 'Invalid email' }
end
