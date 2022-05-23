class User < ApplicationRecord

  attr_accessor :skip_some_callbacks

  devise :omniauthable, omniauth_providers: %i[google_oauth2]
         
  before_create :confirmation_token, unless: :skip_some_callbacks
  has_secure_password
  has_one_attached :avatar
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friends

  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp, message: 'Invalid email' }

  scope :all_except, -> (user) { where.not(id: user) }

  def self.from_omniauth(auth)
    debugger
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.email_confirmed = auth.info.email_verified
        user.skip_some_callbacks = true
      end
    end
    user
  end

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