class Dashboard::RequestOffsController < ApplicationController
  load_and_authorize_resource class: RequestOff.name
  load_and_authorize_resource :user
  def index
    @request_offs = @user.request_offs.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end
end
