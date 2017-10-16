require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  let(:user) {create(:user)}
  let(:token) {JsonWebToken.encode({user_id: user.id})}
  let(:header) { {'Authorization' => token} }
  subject(:invalid_request_obj) { described_class.new() }
  subject(:request_obj) { described_class.new(header) }

  describe '#call' do

    context 'when valid request' do
      it 'returns the right user' do
        request = request_obj.call
        expect(request[:user]).to eq(user)
      end
    end

    context 'when invalid request' do

      context 'when missing token' do
        it 'raises a missing token error' do
          expect {invalid_request_obj.call} .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        let(:header) { {'Authorization' => JsonWebToken.encode({user_id: 1000})} }

        it 'raises an invalid token error' do
          expect {AuthorizeApiRequest.new(header).call} .to raise_error(ExceptionHandler::InvalidToken, 'Invalid token')
        end
      end

      context 'when token expired' do
        let(:header) { {'Authorization' => JsonWebToken.encode({user_id: user.id}, Time.now.to_i - 10) } }
        subject(:request_obj) { AuthorizeApiRequest.new(header) }

        it 'raises an expired signature error' do
          expect {request_obj.call} .to raise_error ExceptionHandler::ExpiredSignature
        end
      end

    end

  end

























  # describe '#call' do
  #   context 'when valid request' do
  #     it 'returns user object' do
  #       result = request_obj.call
  #       expect(result[:user]).to eq(user)
  #     end
  #   end
  #
  #   context 'when invalid request' do
  #     context 'when missing token' do
  #       it 'raises a missing token error' do
  #         expect {invalid_request_obj.call} .to raise_error(ExceptionHandler::MissingToken)
  #       end
  #     end
  #
  #     context 'when invalid token' do
  #
  #
  #
  #       it 'raises an invalid token error' do
  #         expect {invalid_request_obj} .to raise_error(ExceptionHandler::InvalidToken)
  #       end
  #     end
  #   end
  #
  #
  # end


end
