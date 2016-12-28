require "json_response"

class ApplicationController < ActionController::Base
  serialization_scope :view_context
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone, if: :current_user

  rescue_from CanCan::AccessDenied do
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  private

  def set_time_zone
    session[:timezone] = current_user.company.company_setting_timezone
    Time.zone = ActiveSupport::TimeZone[session[:timezone]] if session[:timezone]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation)
                 .merge validate_employee_code: false
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :password, :password_confirmation, :current_password
    end
  end

  def after_sign_in_path_for resource
    if resource.manager?
      dashboard_company_time_sheets_path(current_user.company)
    else
      request_offs_path
    end
  end

  def authenticate_manager!
    return if current_user.manager?
    flash[:warning] = t "you_do_not_have_access"
    redirect_to :back
  end

  JsonResponse::STATUS_CODE.keys.each do |status|
    define_method "response_#{status}" do |message = "", content = {}|
      render json: JsonResponse.send(status, message, content)
    end
  end
end
