class Dashboard::SetTimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_file, only: :create

  def create
    if TimeSheet.import params[:file]
      flash[:success] = t "import_success"
    else
      flash[:danger] = t "error_format_file"
    end
  rescue StandardError
    flash[:danger] = t "file_format_not_right"
    redirect_to dashboard_time_sheets_path
  end

  private
  def load_file
    return if params[:file].present?
    flash[:notice] = t "please_you_choose_file"
    redirect_to dashboard_time_sheets_path
  end
end
