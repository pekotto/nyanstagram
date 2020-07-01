class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    @post_comments = @post.comments
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @post = @comment.post
    @comment.destroy
  end

	private
	 def comment_params
    	params.require(:comment).permit(:comment)
	 end
end
