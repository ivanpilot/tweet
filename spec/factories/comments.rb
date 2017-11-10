FactoryGirl.define do
  factory :comment do
    description { Faker::Lorem.sentence }
    association :post
    association :commenter, factory: :user
  end
end
