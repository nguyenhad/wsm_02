class Dashboard::RequestLeavesController < DashboardController
  load_and_authorize_resource class: RequestLeave.name

  def index
    @search = RequestLeave.ransack params[:q]
    @request_leaves = @search.result.order(created_at: :desc).page(params[:page])
      .per Settings.user.user_request_leave.per_page
    @statuses = RequestLeave.statuses
  end

  def new; end
end
