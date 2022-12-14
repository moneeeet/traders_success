class Public::ReportsController < ApplicationController
  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_user.id
    @report.reported_id = @user.id
    if @report.save
      redirect_to public_user_path(@user)
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end
end
