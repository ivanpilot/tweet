class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # rescue_from ActiveRecord::RecordNotFound, with: :show_errors
  #
  # protected
  # def show_errors
  #   render json: {error: "it is raining" }, status: :not_found
  # end
end
