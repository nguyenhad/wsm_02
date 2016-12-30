class RequestLeavesController < ApplicationController
  load_and_authorize_resource except: [:index]

  def index
    @request_leaves = current_user.request_leaves.page params[:page]
    @user_leave = current_user.user_leaves
      .find_by year: Time.zone.now.year, month: Time.zone.now.month
  end

  def new
    @request_leave.build_compensation
    @leave_types = @company.leave_types.pluck :id, :name
    @leave_settings = @company.leave_settings.map{|leave| [leave.id, leave.name]}
  end

  def destroy
    if @request_leave.destroy
      flash[:notice] = flash_message(:destroy, RequestLeave)
    else
      flash[:error] = flash_message(:destroy, RequestLeave, false)
    end
    redirect_to request_leaves_url
  end
end
