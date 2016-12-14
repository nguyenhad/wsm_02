require "json_response"

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

  def authenticate_manager!
    unless current_user.manager?
      flash[:warning] = t "you_do_not_have_access"
      redirect_to :back
    end
  end

  JsonResponse::STATUS_CODE.keys.each do |status|
    define_method "response_#{status}" do |message = "", content = {}|
      render json: JsonResponse.send(status, message, content) and return
    end
  end
end
