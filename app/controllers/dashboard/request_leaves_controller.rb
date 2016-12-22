class Dashboard::RequestLeavesController < ApplicationController
  load_and_authorize_resource class: RequestLeave.name

  def index
  end

  def new
  end
end
