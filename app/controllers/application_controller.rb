class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation).
        merge validate_employee_code: false
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :password, :password_confirmation, :current_password
    end
  end

  def verify_manager
    unless current_user.manager?
      flash[:danger] = t "you_do_not_have_access"
      redirect_to root_url
    end
  end
end
