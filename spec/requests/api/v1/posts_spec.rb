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
    let(:valid_attributes) { {post: {title:"Valid post", body:"Valid post body"}} }

    context 'when post request is valid' do
      before { post "/api/posts", params: valid_attributes }

      it 'creates a new post' do
        expect(json["title"]).to eq('Valid post')
        expect(json["body"]).to eq('Valid post body')
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when post request is invalid' do
      describe 'because title is missing' do
        before { post "/api/posts", params: { post: {body: "Invalid post"} } }

        it 'returns a status code of 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns validation failure message' do
          expect(response.body).to match(/Validation failed/)
        end
      end

      describe 'because body is missing' do
        before { post "/api/posts", params: { post: {body: "Invalid post"} } }

        it 'returns a status code of 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns validation failure message' do
          expect(response.body).to match(/Validation failed/)
        end
      end
    end
  end

  describe 'PUT /api/posts/:id' do
    let(:valid_attributes) { {title: "Updated Title"} }

    context 'when the record exists' do
      before { put "/api/posts/#{post_id}", params: valid_attributes }

      it 'updates the record' do
      end

      it 'returns a status code of 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exists' do
      before { put "api/posts/1000", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Post not found/)
      end
    end
  end

  describe 'DELETE api/posts/:id' do
    before { delete "/api/post/#{post_id}" }

    context 'when the record does not exists' do
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Post not found/)
      end
    end

    context 'when the record exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

  end

end
