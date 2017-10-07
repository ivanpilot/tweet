class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def create
    @post = Post.create(post_params)
    render json: @post, status: :created
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      render json: @post, status: :ok
    else
      render json: { error: 'Post not found.' }, status: :not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
