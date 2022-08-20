class Admin::PostCommentsController < ApplicationController

  def destroy
    @post_comment = PostComment.find(params[:id])
    if @post_comment.destroy
      redirect_to request.referer
    else
      render admin_comment_reports_path
    end

  end
end
