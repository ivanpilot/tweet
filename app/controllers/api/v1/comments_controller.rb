class Api::V1::CommentsController < ApplicationController
  before_action :find_post#, only: [:index, :create, :show]
  before_action :find_comment, only: [:show, :update, :destroy]

  def index
    @comments = @post.comments if @post
    json_response(@comments)
  end

  #it will change significantly once we implement user loggedin
  def create
    # binding.pry
    #if @user && @user.posts.include(@post)

    @comment = @post.comments.create!(comment_params)
    json_response(@comment, :created)
  end

  def show
    # binding.pry
    json_response(@comment)
  end

  def update
    @comment.update(comment_params)
    json_response(@comment)
  end

  def destroy
    @comment.delete
    @comment = nil
    # render json: { error: 'Post not found.' }, status: :not_found
    head(:ok)
    # json_response()
  end


  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commenter_id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id]) if @post
    # binding.pry
  end

end
