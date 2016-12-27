class RequestLeavesController < ApplicationController
  load_and_authorize_resource except: [:index]

  def index
    @request_leaves = current_user.request_leaves.page params[:page]
  end

  def new
    @request_leave.build_compensation
  end
end
