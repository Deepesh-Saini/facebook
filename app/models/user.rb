class User < ApplicationRecord
  before_create :confirmation_token
  has_secure_password
  has_one_attached :avatar
  has_many :messages
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friends
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp, message: 'Invalid email' }
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end