class Admin::CommentReportsController < ApplicationController
  def index
    @comment_reports = CommentReport.all
  end

  def show
    @comment_report = CommentReport.find(params[:id])
  end

  def update
    @comment_report = CommentReport.find(params[:id])
    if @comment_report.update(report_params)
      flash[:notice] = "対応ステータスを更新しました。"
　　  redirect_to request.referer
    end
  end

  private

  def report_params
    params.require(:comment_report).permit(:comment_report_status)
  end
end
