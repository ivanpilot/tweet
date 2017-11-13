require 'rails_helper'

RSpec.describe 'Comment', type: :request do

  # let(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { {
    "Content_Type" => "application/json",
    # "Authorization" => auth_token
  } }
  let(:user) { create(:user) }
  let!(:tweet) { create(:post) }
  let(:tweet_id) { tweet.id }
  let!(:comments) { FactoryGirl.create_list(:comment, 3, commenter_id: user.id, post_id: tweet_id) }


  describe 'GET /api/posts/:post_id/comments' do
    before { get "/api/posts/#{tweet_id}/comments", headers: headers }

    context 'when tweet item exists' do
      it 'returns all comments that belongs to a specific post' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when tweet item does not exist' do
      before { get "/api/posts/1000/comments", headers: headers }
      # let(:tweet_id) { 1000 } >> can't write the test by changing the tweet_id
      # as this will also change the tweet_id when creating comments and given
      # validation in comment model, post must exists for comment to be created

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /api/posts/:post_id/comments/:id' do
    let(:comment) { create(:comment, post_id: tweet_id, commenter_id: user.id)}
    let(:id) { comment.id }
    before { get "/api/posts/#{tweet_id}/comments/#{id}" }

    context 'when a tweet item exists' do
      it 'returns the comment item' do
        expect(json['id']).to eq(id)
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when a tweet item does not exist' do
      before { get "/api/posts/1000/comments/#{id}" }
      # let(:tweet_id) { 1000 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end

      it 'returns a status code of 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when a comment item does not exist' do
      let(:id) { 1000 }
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end

      it 'returns a status code of 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


  describe 'POST /api/posts/:post_id/comments' do
    let(:attributes) { {comment: {description:"this is a valid comment", post_id: tweet_id, commenter_id: user.id}} }
    before { post "/api/posts/#{tweet_id}/comments", params: attributes, headers: headers }

    context 'when a comment is valid' do
      describe 'if a post is valid' do
        it 'creates a new comment' do
          expect(json["description"]).to eq('this is a valid comment')
        end

        it 'returns a status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      describe 'if a post is not valid' do
        before { post "/api/posts/1000/comments", params: attributes, headers: headers }

        it 'returns a not found Post message' do
          expect(response.body).to match(/Couldn't find Post/)
        end

        it 'returns a status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'when a comment is not valid' do
      describe 'because no params is provided' do
        let(:attributes) { }

        it 'returns a status code 404' do
          expect(response).to have_http_status(404)
        end
      end

      describe 'because no description is provided' do
        let(:attributes) { {comment: {post_id: tweet_id, commenter_id: user.id}} }

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed/)
        end

        it 'returns a status code 422' do
          expect(response).to have_http_status(422)
        end
      end

      # below test is not needed as already provided via testing if post not found given that controller action is @post.comments...
      # describe 'because no post_id is provided' do
      #   let(:attributes) { {comment: {description:"this is a valid comment", commenter_id: user.id}} }
      #
      #   it 'returns a status code 422' do
      #     expect(response).to have_http_status(422)
      #   end
      # end

      describe 'because no commenter_id is provided' do
        let(:attributes) { {comment: {description:"this is a valid comment", post_id: tweet_id}} }

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed/)
        end

        it 'returns a status code 422' do
          expect(response).to have_http_status(422)
        end
      end

    end
  end

  describe 'PUT /api/posts/:post_id/comments/:id' do
    let(:comment_first) { comments.first }
    let(:attributes) { {comment: {description: "this is an updated comment"}} }
    before { put "/api/posts/#{tweet_id}/comments/#{comment_first.id}", params: attributes, headers: headers }

    context 'when a comment is valid' do
      describe 'if a post is valid' do
        it 'updates a the current comment record' do
          comment_first.reload
          expect(json["description"]).to eq('this is an updated comment')
        end

        it 'returns a status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      describe 'if a post is not valid' do
        before { put "/api/posts/1000/comments/#{comment_first.id}", params: attributes, headers: headers }

        it 'returns a not found Post message' do
          expect(response.body).to match(/Couldn't find Post/)
        end

        it 'returns a status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'when a comment is not valid' do
      describe 'because no params is provided' do
        let(:attributes) { }

        it 'returns a status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end
  end

  describe 'DELETE /api/posts/:post_id/comments/:id' do
    let(:comment_first) { comments.first }
    before { delete "/api/posts/#{tweet_id}/comments/#{comment_first.id}", headers: headers }

    context 'when a post exists' do
      describe 'if a comment exists' do
        it 'delete the current comment' do
          expect(response).to have_http_status(200)
        end
      end

      describe 'if a comment does not exist' do
        before { delete "/api/posts/#{tweet_id}/comments/1000", headers: headers }

        it 'returns a not found Comment message' do
          expect(response.body).to match(/Couldn't find Comment/)
        end

        it 'returns a status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'when a post does not exist' do
      before { delete "/api/posts/1000/comments/#{comment_first.id}", headers: headers }

      it 'returns a not found Post message' do
        expect(response.body).to match(/Couldn't find Post/)
      end

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
