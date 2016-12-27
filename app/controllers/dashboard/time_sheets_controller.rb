class Dashboard::TimeSheetsController < DashboardController
  before_action :authenticate_user!
  before_action :load_company, only: :index
  before_action :load_workspace, only: :index
  before_action :load_month_year, only: :index

  def index
    respond_to do |format|
      format.html
      format.json do
        @usertimesheets = UserTimeSheetService.new(@company, @month, @year)
          .build_hash_timesheet
        response_success(t("dashboard.load_timesheet_success"), @usertimesheets)
      end
    end
  end

  private

  def load_company
    @company = Company.find_by id: current_user.company_id
    return if @company
    flash[:error] = t ".company_not_found"
    redirect_to root_path
  end

  def load_workspace
    @workspace = Workspace.find_by id: params[:workspace_id]
    return if @workspace
    flash[:error] = t ".company_not_found"
    redirect_to dashboard_set_timesheets_path
  end

  def load_month_year
    current_time = Time.current
    @month = params[:month] ? params[:month].to_i : current_time.month
    @year = params[:year] ? params[:year].to_i : current_time.year
  end
end
