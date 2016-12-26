class Dashboard::SetTimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_company, only: :create
  before_action :load_file, only: :create
  before_action :load_timesheet_setting, only: :create
  before_action :load_month_year, only: :create

  def index
    @companies = Company.parent_company(current_user.id)
      .recent.page(params[:page])
      .per Settings.per_page.dashboard.company_page
  end

  def create
    begin
      if TimeSheet.import params[:file], @timesheet_setting, @month, @year
        flash[:success] = t ".import_success"
      else
        flash[:error] = t ".error_format_file"
      end
    rescue StandardError
      flash[:error] = t ".file_format_not_right"
    end
    redirect_to dashboard_company_time_sheets_path(@company,
      month: @month, year: @year)
  end

  private

  def load_file
    return if params[:file].present?
    flash[:notice] = t ".please_you_choose_file"
    redirect_to dashboard_company_time_sheets_path(@company,
      month: @month, year: @year)
  end

  def load_timesheet_setting
    @timesheet_setting = @company.timesheet_setting
    return if @timesheet_setting
    flash[:error] = t ".you_must_setting_timesheet"
    redirect_to dashboard_company_time_sheets_path(@company,
      month: @month, year: @year)
  end

  def load_company
    @company = Company.find_by id: params[:company_id]
    return if @company
    flash[:error] = t ".company_not_found"
    redirect_to dashboard_set_timesheets_path
  end

  def load_month_year
    current_time = Time.current
    @month = params[:month] ? params[:month].to_i : current_time.month
    @year = params[:year] ? params[:year].to_i : current_time.year
  end
end
