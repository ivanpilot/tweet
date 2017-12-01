class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :react_id
  has_many :comments
  belongs_to :author, include: :username
end
