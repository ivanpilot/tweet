class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'User'

  validates :description, :post_id, :commenter_id, presence: true
end
