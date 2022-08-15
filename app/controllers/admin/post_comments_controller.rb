class Admin::PostCommentsController < ApplicationController
  def edit
    @post_comment = PostComment.find(params[:comment_id])
  end

  def update
    @post_comment = PostComment.find(params[:comment_id])
    if @post_comment.update(comment_report_params)
      redirect_to admin_user_path(@user), notice: "#{@user.name}さんの会員ステータスを更新しました"
    else
      render "edit"
    end
  end

  private

  def comment_report_params
    params.require(:comment_report).permit(:comment_report_status)
  end
end
