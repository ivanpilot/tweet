class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    #render json: @posts, status: :ok
    json_response(@posts)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      #render json: @post, status: :created
      json_response(@posts, :create)
    else
      render json: { error: "Validation failed" }, status: :unprocessable_entity
    end
  end

  def show
    # @post = Post.find(id: params[:id])
    # if @post
    #   render json: @post, status: :ok
    # else
    #   render json: { error: 'Post not found.' }, status: :not_found
    # end
    #begin
      @post = Post.find(params[:id])
      render json: @post, status: :ok
      #json_response(@posts)
    # rescue => e
    #  render json: { error: 'test' }, status: :not_found
  # rescue ActiveRecord::RecordNotFound
  #     render json: { error: "test" }, status: :not_found
  #   end
#   rescue ActiveRecord::RecordNotFound => e
#   render json: {
#     error: e.to_s
#   }, status: :not_found
# end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.update(post_params)
      render json: @post, status: :ok
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
      @post = nil
      head(:ok)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
