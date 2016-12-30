class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!

  layout "dashboard"

  protected

  def load_workspace
    @workspace = Workspace.find_by id: params[:id]
    return if @workspace.present?
    flash[:danger] = t "dashboard.workspaces.load_fails"
    redirect_to root_path
  end

  def verify_owner_workspace
    return if current_user.is_owner_workspace?
    flash[:danger] = t "dashboard.workspaces.unauthorized"
    redirect_to root_path
  end
end
