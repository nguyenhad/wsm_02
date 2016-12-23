class Dashboard::TimeSheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_company, only: :index

  def index
    respond_to do |format|
      format.html
      format.json do
        current_time = Time.current
        month = params[:month] ? params[:month].to_i : current_time.month
        year = params[:year] ? params[:year].to_i : current_time.year
        @usertimesheets = UserTimeSheetService.new(@company,
          month, year).build_hash_timesheet
        response_success(t("dashboard.load_timesheet_success"), @usertimesheets)
      end
    end
  end

  private

  def load_company
    @company = Company.find_by id: params[:company_id]
    return if @company
    flash[:error] = t ".company_not_found"
    redirect_to dashboard_set_timesheets_path
  end
end
