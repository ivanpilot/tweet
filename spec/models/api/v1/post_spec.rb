require 'rails_helper'

RSpec.describe Post, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:post)).to be_valid
  end
  #pending "add some examples to (or delete) #{__FILE__}"
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
end
