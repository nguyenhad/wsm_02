class RequestOffsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
    @request_off = RequestOff.new
  end

  def edit
  end

  def create
    @request_off = RequestOff.new request_off_params

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
      flash[:notice] = flash_messsage(:destroy, RequestOff)
    else
      flash[:error] = flash_messsage(:destroy, RequestOff, false)
    end
    redirect_to request_offs_url
  end

  private

  def request_off_params
    params.require(:request_off).permit RequestOff::ATTR_PARAMS
  end
end
