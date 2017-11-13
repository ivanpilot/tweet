require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }


end
