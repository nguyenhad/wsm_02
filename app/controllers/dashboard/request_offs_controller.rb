class Dashboard::RequestOffsController < ApplicationController
  load_and_authorize_resource class: RequestOff.name
  load_and_authorize_resource :user
  include ApplicationHelper

  def new
  end

  def index
    @request_offs = @user.request_offs.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end

  def destroy
    if @request_off.destroy
      flash[:notice] = flash_message(:destroy, RequestOff)
    else
      flash[:error] = flash_message(:destroy, RequestOff, false)
    end
    redirect_to dashboard_user_request_offs_path
  end
end
