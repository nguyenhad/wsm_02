class Dashboard::RequestLeavesController < ApplicationController
  load_and_authorize_resource class: RequestLeave.name

  def index
    @request_leaves = @request_leaves.page(params[:page])
      .per Settings.user.user_request_leave.per_page
  end

  def new
  end
end
