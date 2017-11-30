class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    # binding.pry
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(email: user.email, password: user.password).call
    response = {
      auth_token: auth_token,
      message: Message.account_created
    }
    json_response(response, :created)
  end

  def user_data
    user = {
      id: current_user.id,
      username: current_user.username,
      email: current_user.email
    }
    json_response(user: user)
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

end
