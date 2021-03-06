require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let!(:auth_token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { {
    "Content_Type" => "application/json",
    "Authorization" => auth_token
  } }
  let(:invalid_headers) { {
    "Content_Type" => "application/json",
    "Authorization" => nil
  } }

  describe '#authorize_request' do
    context 'when auth token is passed' do
      before { allow(request).to receive(:headers).and_return(headers) }

      it "sets the current user" do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context "when auth token is not passed" do
      before { allow(request).to receive(:headers).and_return(invalid_headers) }

      it "raises MissingToken error" do
        expect { subject.instance_eval { authorize_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end

  end
end
