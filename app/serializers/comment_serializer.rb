class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :post_id, :react_id
  belongs_to :post
  belongs_to :commenter, include: :username
end
