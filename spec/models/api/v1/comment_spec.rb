require 'rails_helper'

RSpec.describe Comment, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it {should validate_presence_of :description}
  it {should belong_to :post}
  it {should belong_to :commenter}
  it {should have_db_column :id}
  it {should have_db_column :description}
  it {should have_db_column :post_id}
  it {should have_db_column :commenter_id}

end
