module ExceptionHandler

  # rescue_from ActiveRecord::RecordNotFound do |e|
  #   render json_reponse({e.message}, :not_found )
  # end

  # def self.included(base)
  #   base.class_eval do
  #     rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  #   end
  # end

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {error: e.message}, status: :not_found
    end
  end

  # included do
  #   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # end
  #
  # private
  #
  # def record_not_found
  #   render json: {error: "this is finally WORKING"}, status: :not_found
  #end
end
