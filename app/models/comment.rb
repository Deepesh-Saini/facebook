class Comment < ApplicationRecord
	has_many :comments, as: :commentable, dependent: :destroy
	belongs_to :commentable, polymorphic: true
	validates :body, presence: true
end
