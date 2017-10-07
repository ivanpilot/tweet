require 'rails_helper'

RSpec.describe 'Post Api', type: :request do
  let!(:posts) { FactoryGirl.create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  describe 'GET /api/posts' do
    before { get '/api/posts'}

    it 'returns all posts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/posts/:id' do
    before { get "/api/posts/#{post_id}" }

    context 'when the post exists' do
      it 'returns the right post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the post does not exist' do
      let(:post_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Post not found/)
      end
    end
  end

  describe 'POST /api/posts' do
    let(:valid_attributes) { {title:"Title", body:"Body"} }

    context 'when post request is valid' do
      before { post "/api/posts", params: valid_attributes }

      it 'creates a new post' do
        expect(json.title).to eq('Title')
        expect(json.body).to eq('Body')
      end

      it 'returns a status code 201' do
        expect(reponse).to have_http_status(201)
      end
    end
  end

end
