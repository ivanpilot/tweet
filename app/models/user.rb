class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates :username, :email, uniqueness: true
  #validates :password, presence: true


end
