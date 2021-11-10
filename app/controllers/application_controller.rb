class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_record

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_in_path_for(*)
    flash.clear
    if current_user.admin?
      account_admin_root_path
    else
      account_user_root_path
    end
  end

  def user_access_denied
    flash["alert"] = 'Access denied'
    render file: "public/401.html", status: :unauthorized
  end

  def not_found_record
    flash["alert"] = 'Record not found'
    render file: "public/404.html", status: :not_found
  end
end
