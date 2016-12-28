class Dashboard::RequestLeavesController < DashboardController
  load_and_authorize_resource class: RequestLeave.name

  def index
    @search = RequestLeave.ransack params[:q]
    @request_leaves = @search.result.order(created_at: :desc).page(params[:page])
      .per Settings.user.user_request_leave.per_page
    @statuses = RequestLeave.statuses
  end

  def new
    @request_leave.build_compensation
    @leave_types = @company.leave_types.pluck :id, :name
    @leave_settings = @company.leave_settings.map{|leave| [leave.id, leave.name]}
  end

  def update
    if @request_leave.update request_leave_params
      redirect_to dashboard_request_leaves_url,
        notice: flash_message(:update, RequestLeave)
    else
      render :edit
    end
  end

  private

  def request_leave_params
    params.require(:request_leave).permit RequestLeave::ATTR_PARAMS
  end
end
