class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author_id, :react_id
  has_many :comments
end
