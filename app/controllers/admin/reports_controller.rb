class Admin::ReportsController < ApplicationController
  def index
     @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to admin_reports_path
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to admin_reports_index_path
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end
end
