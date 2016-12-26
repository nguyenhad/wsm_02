class RequestOffsController < ApplicationController
  load_and_authorize_resource class: RequestOff.name
  include ApplicationHelper
  def index
    @request_offs = current_user.request_offs.page(params[:page])
      .per Settings.per_page.request_off
  end

  def destroy
    if @request_off.destroy
      flash[:notice] = flash_message(:destroy, RequestOff)
    else
      flash[:error] = flash_message(:destroy, RequestOff, false)
    end
    redirect_to request_offs_url
  end
end
