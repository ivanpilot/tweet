class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
    # @posts = current_user.posts
    json_response(@posts)
  end

  def create
    # binding.pry
    #use create! instead of create so it raises an invalid error
    # @post = Post.create!(post_params)
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  def show
    # binding.pry
    # @post = Post.find(params[:id])
    # @post = current_user.posts.find(params[:id])
    json_response(@post)
  end


  def update
    @post.update!(post_params)
    json_response(@post)
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
    # @post = Post.find(params[:id])
    @post = current_user.posts.find(params[:id])
  end
end
