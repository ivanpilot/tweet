require 'rails_helper'

RSpec.describe 'Post', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { {
    "Content_Type" => "application/json",
    "Authorization" => auth_token
  } }
  let!(:posts) { FactoryGirl.create_list(:post, 10, author_id: user.id) }
  let(:post_id) { posts.first.id }

  describe 'GET /api/posts' do
    before { get '/api/posts', headers: headers}

    it 'returns all posts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/posts/:id' do
    before { get "/api/posts/#{post_id}", headers: headers }

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
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'POST /api/posts' do
    let(:valid_attributes) { {post: {title:"Valid post", body:"Valid post body", author_id: User.first.id}} }

    context 'when post request is valid' do
      before { post "/api/posts", params: valid_attributes, headers: headers }

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
        before { post "/api/posts", params: { post: {body: "Invalid post"} }, headers: headers }

        it 'returns a status code of 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns validation failure message' do
          expect(response.body).to match(/Validation failed/)
        end
      end

      describe 'because body is missing' do
        before { post "/api/posts", params: { post: {body: "Invalid post"} }, headers: headers }

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
    let(:post_first) { posts.first }

    context 'when the record exists' do
      before { put "/api/posts/#{post_first.id}", params: {post: {title: "Updated Title"}}, headers: headers }

      it 'updates the record' do
        post_first.reload
        expect(post_first.title).to eq('Updated Title')
        expect(post_first.body).to eq("#{post_first.body}")
      end

      it 'returns the updated record' do
        expect(json["title"]).to eq('Updated Title')
      end

      it 'returns a status code of 204' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      before { put "/api/posts/10000", params: {post: {title: "Updated Title"}}, headers: headers}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'DELETE api/posts/:id' do
    before { delete "/api/posts/#{post_id}", headers: headers }

    context 'when the record exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      before { delete "/api/posts/100000", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end



  end

end
