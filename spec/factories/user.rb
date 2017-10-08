FactoryGirl.define do
  factory :user do
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email }
    password_digest "password"
  end
end
