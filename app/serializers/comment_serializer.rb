class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :post_id, :commenter_id
  belongs_to :post
end