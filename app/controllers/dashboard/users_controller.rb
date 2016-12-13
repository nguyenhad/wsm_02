class Dashboard::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_company, only: [:new, :edit, :create]

  def index
    User.random_password
    @users = User.includes(:company).recent.page(params[:page])
      .per Settings.per_page.dashboard.user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to dashboard_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to dashboard_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to dashboard_users_path
  end

  private
  def user_params
    params.require(:user)
      .permit(:name, :employee_code, :gender, :birthday, :avatar, :email,
        :role, :company_id).merge password: User.random_password
  end

  def load_company
    @companies = Company.all
  end
end
