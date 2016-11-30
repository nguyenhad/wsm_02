class Dashboard::WorkspacesController < ApplicationController
  before_action :authenticate_user!

  def index
    @workspaces = current_user.owned_workspaces.page(params[:page])
      .per(Settings.workspace.per_page)
    @workspace = Workspace.new
  end

  def new
  end

  def create
    @workspace = current_user.owned_workspaces.new workspace_params
    if @workspace.save
      flash[:success] = t "create_success"
      redirect_to workspaces_path
    else
      render :new
    end
  end

  private
  def workspace_params
    params.require(:workspace).permit :name, :description, :image
  end
end
