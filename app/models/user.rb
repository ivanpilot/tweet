class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates :username, :email, uniqueness: true
  validates :password_digest, presence: true


end
