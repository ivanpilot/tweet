class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts, status: '200'
  end

  def create
    @post = Post.create(post_params)
    render json: @post, status: :created
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
