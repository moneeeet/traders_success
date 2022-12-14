class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @user = @post.user
    @comment.save
  end

  def destroy
   @post = Post.find(params[:post_id])
   @post_comment = PostComment.find(params[:id])
   @post_comment.destroy
   @user = @post.user
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
