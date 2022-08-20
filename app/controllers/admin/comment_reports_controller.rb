class Admin::CommentReportsController < ApplicationController
  def index
    @comment_reports = CommentReport.all

  end

  def show
    @comment_report = CommentReport.find(params[:id])
    @post_comment = PostComment.where(id: @comment_report.post_comment_id).first
    unless @post_comment.present?
      flash[:notice] = "該当のコメントはすでに削除されています。"
      redirect_to admin_comment_reports_path
    end
  end

  def update
    @comment_report = CommentReport.find(params[:id])
    if @comment_report.update(comment_report_params)
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to admin_comment_reports_path
    end
  end

  def edit

  end

  def destroy
    @comment_report = CommentReport.find(params[:id])
    @comment_report.destroy
    redirect_to admin_comment_reports_path
  end

  private

  def comment_report_params
    params.require(:comment_report).permit(:comment_report_status)
  end
end
