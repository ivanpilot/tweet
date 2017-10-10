require 'rails_helper'

RSpec.describe Post, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:post)).to be_valid
  end

  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:user_id)}
  it {should belong_to(:user)}
end
