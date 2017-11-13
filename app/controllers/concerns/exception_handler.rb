module ExceptionHandler

  extend ActiveSupport::Concern

  class ExpiredSignature < StandardError; end
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class MissingEmail < StandardError; end
  class MissingPassword < StandardError; end
  class InvalidEmailPassword < StandardError; end


  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({message: e.message}, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({message: e.message}, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingEmail, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingPassword, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_twenty_two
  end

  def four_twenty_two(e)
    json_response({message: e.message}, :unprocessable_entity)
  end

  def unauthorized_request(e)
    json_response({message: e.message}, :unauthorized)
  end

end
