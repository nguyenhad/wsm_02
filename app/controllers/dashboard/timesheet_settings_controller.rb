class Dashboard::TimesheetSettingsController < DashboardController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_timesheet_setting, only: [:edit, :update, :show]
  before_action :load_workspace, except: :destroy

  def index
    @timesheet_settings = TimesheetSetting.load_by_workspace(@workspace.id)
      .recent.page(params[:page])
      .per Settings.per_page.dashboard.timesheet_setting
  end

  def new
    @timesheet_setting = TimesheetSetting.new
  end

  def create
    @timesheet_setting = TimesheetSetting.new timesheet_setting_params
    if @timesheet_setting.save
      flash[:success] = t "dashboard.timesheet_settings.create_successfully"
      redirect_to dashboard_workspace_timesheet_settings_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @timesheet_setting.update_attributes timesheet_setting_params
      flash[:success] = t "dashboard.timesheet_settings.update_successfully"
      redirect_to dashboard_workspace_timesheet_settings_path
    else
      render :edit
    end
  end

  private
  def timesheet_setting_params
    params.require(:timesheet_setting).permit(:layout_type, :value_type,
      :date_format_type, :start_date, :end_date, :start_row_data,
      optional_settings: optional_settings).merge! workspace_id: @workspace.id
  end

  def optional_settings
    if params[:timesheet_setting][:layout_type] == TimesheetSetting.layout_types
      .keys[Settings.timesheet_setting.horizontal]
      [:date, :employee_code, :name, :key]
    else
      [:time_in, :time_out, :date, :employee_code, :name, :key]
    end
  end

  def load_timesheet_setting
    @timesheet_setting = TimesheetSetting.find_by id: params[:id]
    return if @timesheet_setting
    flash[:danger] = t "dashboard.timesheet_settings.not_found"
    redirect_to dashboard_workspace_timesheet_settings_path
  end

  def load_workspace
    @workspace = Workspace.find_by id: params[:workspace_id]
    return if @workspace
    flash[:danger] = t "dashboard.timesheet_settings.not_found"
    redirect_to dashboard_workspaces_path
  end
end
