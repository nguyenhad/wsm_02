class RequestLeavesController < ApplicationController
  def index
    @request_leaves = current_user.request_leaves.page params[:page]
  end
end
