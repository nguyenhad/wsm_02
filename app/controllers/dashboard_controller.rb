class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :load_workspace
  # before_action :verify_owner

  layout "dashboard"

  protected

  def load_workspace
    @workspace = Workspace.find_by id: params[:id]
    return if @workspace.present?
    flash[:danger] = t "dashboard.workspaces.load_fails"
    redirect_to root_path
  end

  def verify_owner
    return if current_user.is_owner? @workspace
    flash[:danger] = t "dashboard.workspaces.unauthorized"
    redirect_to root_path
  end
end
