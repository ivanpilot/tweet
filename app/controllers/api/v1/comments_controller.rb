class Api::V1::CommentsController < ApplicationController
  before_action :find_post, only: [:index]

  def index
    @comments = @post.comments if @post
    json_response(@comments)
  end


  private
  def comment_params
    params.require(:comment).permit(:description)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

end
