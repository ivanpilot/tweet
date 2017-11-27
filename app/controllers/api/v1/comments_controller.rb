class Api::V1::CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:show, :update, :destroy]

  def index
    @comments = @post.comments if @post
    json_response(@comments)
  end

  #it will change significantly once we implement user loggedin
  def create
    #if @user && @user.posts.include(@post)
    @comment = @post.comments.create!(comment_params)
    json_response(@comment, :created)
  end

  def show
    json_response(@comment)
  end

  #it will change significantly once we implement user loggedin
  def update
    #if @user && @user.posts.include(@post)
    @comment.update(comment_params)
    json_response(@comment)
  end

  def destroy
    @comment.delete
    @comment = nil
    head(:ok)
  end


  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commenter_id, :react_id)
  end

  def find_post
    raw_post_id = params[:post_id]
    post_id = raw_post_id.to_i.to_s == raw_post_id ? raw_post_id : nil
    @post = Post.find(post_id)
    # @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id]) if @post
  end

  # def post_params
  #   params.require(:post_id)#.permit(:post_id)
  # end

end
