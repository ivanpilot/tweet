class Api::V1::CommentsController < ApplicationController
  before_action :find_post, only: [:index, :create, :show]
  before_action :find_comment, only: [:show]

  def index
    @comments = @post.comments if @post
    json_response(@comments)
  end

  # def create
  #   binding.pry
  #   #if @user && @user.posts.include(@post)
  #   @comment = @post.comments.create!(comment_params)
  #   json_response(@comment, :created)
  # end

  def show
    # binding.pry
    json_response(@comment)
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
  end

end
