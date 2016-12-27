class Dashboard::SetUsersController < DashboardController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  before_action :load_file, only: :create

  def create
    begin
      if User.import params[:file]
        flash[:success] = t "import_success"
      else
        flash[:danger] = t "error_format_file"
      end
    rescue StandardError
      flash[:danger] = t "file_format_not_right"
    end
    redirect_to dashboard_users_path
  end

  private
  def load_file
    return if params[:file].present?
    flash[:warning] = t "please_you_choose_file"
    redirect_to dashboard_users_path
  end
end
