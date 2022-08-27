class Public::CommentReportsController < ApplicationController
  def new
    @comment_report = CommentReport.new
    @user = current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @user_id = PostComment.find(params[:post_comment_id]).user_id
    @comment_report = CommentReport.new(report_params)
    @comment_report.comment_reporter_id = current_user.id
    @comment_report.comment_reported_id = @user_id
    @comment_report.post_comment_id = params[:post_comment_id]
    if @comment_report.save
      redirect_to public_post_path(@post), notice: "ご報告ありがとうございます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:comment_report).permit(:reason, :url)
  end
end
