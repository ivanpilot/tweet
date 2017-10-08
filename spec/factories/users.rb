FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name.unique }
    email { Faker::Internet.email.unique }
    password_digest { Faker::Internet.password(8) }
  end
end
