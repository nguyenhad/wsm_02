class Dashboard::CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_manager!
  load_and_authorize_resource except: [:index, :new, :create]

  def index
    @companies = Company.parent_company(current_user.id)
      .recent.page(params[:page])
      .per Settings.per_page.dashboard.company_page
  end

  def show
    @company_setting = CompanySetting.find_by id: params[:id]
    unless @company_setting
      flash[:warning] = t "dashboard.company.not_setting_message"
      redirect_to dashboard_companies_path
    end
  end

  def edit
  end

  def update
    if @company.update_attributes company_params
      flash[:success] = t "dashboard.company.update_successfully"
      redirect_to dashboard_company_path @company
    else
      render :edit
    end
  end

  def destroy
    if @company.company_setting.destroy
      flash[:success] = t "dashboard.company.update_successfully"
    else
      t "flash.danger_message"
    end
    redirect_to dashboard_company_path @company
  end

  private

  def company_params
    params.require(:company).permit :name,
      company_setting_attributes: [:id, :cutoff_date]
  end
end
