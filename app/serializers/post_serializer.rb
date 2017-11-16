class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author_id
  has_many :comments
end
