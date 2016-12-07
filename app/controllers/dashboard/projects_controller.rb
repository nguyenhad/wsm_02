class Dashboard::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_manager
  before_action :load_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.recent.page(params[:page])
      .per Settings.per_page.dashboard.project
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = t "dashboard.projects.create_successfully"
      redirect_to dashboard_projects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes project_params
      flash[:success] = t "dashboard.projects.update_successfully"
      redirect_to dashboard_projects_path
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = t "dashboard.projects.delete_successfully"
    else
      flash[:warning] = t "dashboard.projects.delete_not_success"
    end
    redirect_to dashboard_projects_path
  end

  private
  def project_params
    params.require(:project).permit :name, :start_date, :end_date
  end

  def load_project
    @project = Project.find_by_id params[:id]
    unless @project
      flash[:warning] = t "dashboard.projects.not_found"
      redirect_to dashboard_projects_path
    end
  end
end
