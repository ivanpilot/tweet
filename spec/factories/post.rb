FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    association :author, factory: :user
  end
end
