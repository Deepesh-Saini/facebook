class Post < ApplicationRecord

	
  
	belongs_to :user
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, as: :post,  dependent: :destroy
	has_one_attached :avatar

	VALID_STATUSES = ['Public', 'Private']
	validates :status, presence: true, inclusion: { in: VALID_STATUSES }
	validates :body, presence: true

	def private?
		status == 'Private'
	end

	def liked?(user)
		!!self.likes.find{|like| like.user_id == user.id}
	end
end