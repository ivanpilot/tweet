class AuthenticateUser

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
  attr_reader :email, :password

  # def authenticated_user
  #   @user = user
  #   if password.nil?
  #     raise ExceptionHandler::MissingPassword
  #   end
  #   if password && @user.try(:authenticate, password)
  #     return @user
  #   end
  #   raise ExceptionHandler::AuthenticationError
  # end

  def user
    user = User.find_by(email: email)
    return user if user and user.try(:authenticate, password)
    raise ExceptionHandler::AuthenticationError
  end

end
