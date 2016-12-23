class Dashboard::TimeSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json do
        current_time = Time.current
        month = params[:month] ? params[:month].to_i : current_time.month
        year = params[:year] ? params[:year].to_i : current_time.year
        @company = current_user.company
        @usertimesheets = UserTimeSheetService.new(@company,
          month, year).build_hash_timesheet
        response_success(t("dashboard.load_timesheet_success"), @usertimesheets)
      end
    end
  end
end
