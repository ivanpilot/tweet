require 'rails_helper'

RSpec.describe AuthenticateUser do

  let (:user) { create(:user) }
  subject (:valid_obj) { described_class.new(email: user.email, password: user.password) }
  subject (:invalid_obj) { described_class.new(email: 'foo', password: 'bar') }

  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth_token' do
        token = valid_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect {invalid_obj.call} .to raise_error(ExceptionHandler::AuthenticationError)
      end
    end
  end

end
