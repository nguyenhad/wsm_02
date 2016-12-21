class Dashboard::TimeSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @company = current_user.company
    @usertimesheets = UserTimeSheetService.new(@company,
      Time.current.month, Time.current.year).build_hash_timesheet
    respond_to do |format|
      format.html
      format.json do
        response_success(t("dashboard.load_timesheet_success"), @usertimesheets)
      end
    end
  end
end
