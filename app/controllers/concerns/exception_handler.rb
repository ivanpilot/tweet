module ExceptionHandler

  extend ActiveSupport::Concern

  class ExpiredSignature < StandardError; end
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end


  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({error: "was really not found"}, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({error: "validation failed"}, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::ExpiredSignature do |e|
      json_response({error: "Token's signature has expired"}, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::AuthenticationError do |e|
      json_response({error: "Authentication failed. Please try again"}, :unauthorized_request)
    end

    rescue_from ExceptionHandler::MissingToken do |e|
      json_response({error: "Missing token"}, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::InvalidToken do |e|
      json_response({error: "Invalid token"}, :unprocessable_entity)
    end

  end

end
