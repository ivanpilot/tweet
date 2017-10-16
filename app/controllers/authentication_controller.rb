class AuthenticationController < ApplicationController

  def login
    auth_token = AuthenticateUser.new(email: auth_params["email"], password: auth_params["password"]).call
    render json: {auth_token: auth_token}, status: :ok
    # json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

end
