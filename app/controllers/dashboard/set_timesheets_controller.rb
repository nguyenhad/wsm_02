class Dashboard::SetTimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_file, only: :create
  before_action :load_timesheet_setting, only: :create

  def create
    begin
      if TimeSheet.import params[:file], @timesheet_setting
        flash[:success] = t "import_success"
      else
        flash[:error] = t "error_format_file"
      end
    rescue StandardError
      flash[:error] = t "file_format_not_right"
    end
    redirect_to dashboard_time_sheets_path
  end

  private

  def load_file
    return if params[:file].present?
    flash[:notice] = t "please_you_choose_file"
    redirect_to dashboard_time_sheets_path
  end

  def load_timesheet_setting
    @timesheet_setting = TimesheetSetting.find_by company_id:
      current_user.company_id
    return if @timesheet_setting
    flash[:error] = t "you_must_setting_timesheet"
    redirect_to dashboard_time_sheets_path
  end
end
