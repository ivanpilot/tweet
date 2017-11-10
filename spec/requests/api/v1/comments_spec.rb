require 'rails_helper'

RSpec.describe 'Comment', type: :request do
  # let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { {
    "Content_Type" => "application/json"
    # "Authorization" => auth_token
  } }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:post_id) { post.id }
  # let!(:comment) { create(:comment, post_id: post.id, commenter_id: user.id) }
  # let!(:comment) { create(:comment, description:'hey', post_id: post.id, commenter_id: user.id) }
  # let(:comment) { create(:comment, commenter_id: user.id, post_id: post.id) }
  let!(:comments) { FactoryGirl.create_list(:comment, 3, commenter_id: user.id, post_id: post_id) }

  describe 'GET /api/posts/:id/comments' do
    before { get "/api/posts/#{post.id}/comments", headers: headers }

    context 'when post exits' do
      it 'returns all comments that belongs to a specific post' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when post does not exist' do
      before { get "/api/posts/1000/comments", headers: headers }

      it 'returns a not found message' do
        expect(response.body).to match(/not found/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end


  end


end
