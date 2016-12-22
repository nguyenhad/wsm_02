class RequestOffsController < ApplicationController
  load_and_authorize_resource class: RequestOff.name, except: [:index]
  include ApplicationHelper

  def index
    @request_offs = current_user.request_offs.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end

  def new; end

  def edit; end

  def create
    @request_off = RequestOff.new request_off_params
    @request_off.user = current_user

    if @request_off.save
      redirect_to @request_off, notice: flash_messsage(:create, RequestOff)
    else
      render :new
    end
  end

  def update
    if @request_off.update request_off_params
      redirect_to @request_off, notice: flash_messsage(:update, RequestOff)
    else
      render :edit
    end
  end

  def destroy
    if @request_off.destroy
      flash[:notice] = flash_message(:destroy, RequestOff)
    else
      flash[:error] = flash_message(:destroy, RequestOff, false)
    end
    redirect_to request_offs_url
  end

  private

  def request_off_params
    params.require(:request_off).permit RequestOff::ATTR_PARAMS
  end
end
