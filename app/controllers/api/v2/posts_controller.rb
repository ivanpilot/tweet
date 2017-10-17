class Api::V2::PostsController < ApplicationController

  def index
    render json: {message: 'what the fuck'}, status: :ok
  end

end
