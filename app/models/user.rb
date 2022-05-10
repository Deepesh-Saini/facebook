class User < ApplicationRecord
  before_create :confirmation_token
  has_secure_password
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp, message: 'Invalid email' }

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private
  def confirmation_token
    #if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    #end
  end

end