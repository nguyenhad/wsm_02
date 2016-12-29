class Dashboard::WhiteListsController < DashboardController
  before_action :load_whitelist
  before_action :load_user, only: [:update, :index]

  def index
    @users = User.of_ids(@whitelist.list_user).page(params[:page])
      .per Settings.per_page.dashboard.user
  end

  def update
    list_user = whitelist_params.values.first.map(&:to_i)
    @whitelist.list_user = @whitelist.list_user + list_user
    if @whitelist.save
      flash[:success] = t "dashboard.whitelist.update.update_success"
    else
      flash[:warning] = t "dashboard.whitelist.update.update_fail"
    end
    redirect_to dashboard_white_lists_path
  end

  def destroy
    list_user = @whitelist.list_user.delete params[:user].to_i
    if list_user && @whitelist.save
      flash[:success] = t "dashboard.whitelist.destroy.delete_success"
    else
      flash[:warning] = t "dashboard.whitelist.destroy.delete_fail"
    end
    redirect_to dashboard_white_lists_path
  end

  private
  def load_whitelist
    @whitelist = WhiteList.find_or_create_by company_id: current_user.company_id
    return if @whitelist
    flash[:waring] = t "dashboard.whitelist.index.find_whitelist_fail"
    redirect_to root_path
  end

  def load_user
    @users_out = current_user.company.without_whitelist
  end

  def whitelist_params
    params[:white_list].permit(list_user: [])
  end
end
