class Dashboard::RequestOffsController < DashboardController
  load_and_authorize_resource class: RequestOff.name
  include ApplicationHelper

  def index
    @search = RequestOff.ransack params[:q]
    @request_offs = @search.result.order(created_at: :desc).page(params[:page])
      .per Settings.per_page.dashboard.request_off
    @statuses = RequestOff.statuses
  end

  def show; end

  def new; end

  def edit; end

  def create
    @request_off = RequestOff.new request_off_params

    if @request_off.save
      redirect_to @request_off, notice: flash_message(:create, RequestOff)
    else
      render :new
    end
  end

  def update
    if @request_off.update_attributes request_off_params
      redirect_to dashboard_request_offs_url,
        notice: flash_message(:update, RequestOff)
    else
      render :edit
    end
  end

  private

  def request_off_params
    params.require(:request_off).permit RequestOff::ATTR_PARAMS
  end
end
