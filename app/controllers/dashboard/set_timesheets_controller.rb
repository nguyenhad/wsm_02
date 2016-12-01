class Dashboard::SetTimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_file, only: :create

  def create
    begin
      if TimeSheet.import params[:file]
        flash[:success] = t "import_success"
      else
        flash[:danger] = t "error_format_file"
      end
    rescue Exception
      flash[:danger] = t "file_format_not_right"
    end
    redirect_to dashboard_time_sheets_path
  end

  private
  def load_file
    if params[:file].blank?
      flash[:notice] = t "please_you_choose_file"
      redirect_to dashboard_time_sheets_path
    end
  end

  def authenticate_manager!
    unless current_user.manager?
      flash[:warning] = t "you_are_not_manager"
      redirect_to dashboard_time_sheets_path
    end
  end
end
