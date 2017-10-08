class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { error: "Validation failed" }, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      render json: @post, status: :ok
    else
      render json: { error: 'Post not found.' }, status: :not_found
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.update(post_params)
      render json: @post, status: :no_content
    else
      render json: { error: 'Post not found.' }, status: :not_found
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: { error: 'Post not found.' }, status: :not_found
    else
      @post.delete
      render json: @post, status: :no_content
      @post = nil
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
