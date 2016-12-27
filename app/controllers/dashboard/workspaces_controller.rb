class Dashboard::WorkspacesController < DashboardController
  before_action :load_workspace, except: [:index, :new, :create]
  before_action :verify_owner_workspace, only: :show
  before_action :load_service, only: [:show, :edit]
  protect_from_forgery with: :null_session

  def index
    @workspaces = current_user.owned_workspaces.page(params[:page])
      .per Settings.workspace.per_page
    @workspace = Workspace.new
  end

  def show; end

  def new; end

  def create
    @workspace = current_user.owned_workspaces.new workspace_params
    if @workspace.save
      flash[:success] = t "create_success"
      redirect_to dashboard_workspaces_path
    else
      render :new
    end
  end

  def edit; end

  def update
    build_results = build_workspace_data(params[:nodeDataArray])
    result_msg = build_results[0]
    result_msg.push t(".success", count: build_results[1])
    flash[:info] = safe_join(result_msg.join(Settings.break_line))
    redirect_to action: :edit
  end

  private
  def workspace_params
    params.require(:workspace).permit :name, :description, :image
  end

  def load_service
    @sections = ShowWorkspaceService.new(@workspace).show_hash_workspace
  end

  def build_workspace_data node_data
    services = WorkspaceService.new @workspace
    services.build_sections node_data
    services.build_locations node_data
    services.get_build_results
  end
end
