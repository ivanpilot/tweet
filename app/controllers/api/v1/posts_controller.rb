class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
    json_response(@posts)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      json_response(@post, :created)
    else
      render json: { error: "Validation failed" }, status: :unprocessable_entity
    end
  end

  def show
    json_response(@post)
  end

  def update
    if @post && @post.update(post_params)
      json_response(@post)
    else
      render json: { error: 'Post not found.' }, status: :not_found
    end
  end

  def destroy
    if !@post
      render json: { error: 'Post not found.' }, status: :not_found
    else
      @post.delete
      @post = nil
      head(:ok)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
