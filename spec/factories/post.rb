FactoryGirl.define do
  #user = FactoryGirl.build(:user)
  factory :post do
    title { Faker::Lorem.word}
    body { Faker::Lorem.sentence}
    association :user, factory: :user, strategy: :build
    #user_id {FactoryGirl.build(:user).id}
  end
end
