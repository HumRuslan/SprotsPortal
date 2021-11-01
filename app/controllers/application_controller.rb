class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_access_denied

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_in_path_for(*)
    if current_user.admin?
      account_admin_root_path
    elsif current_user.user?
      root_path
    end
  end

  def user_access_denied
    sign_out current_user
    flash["alert"] = 'Access denied'
    redirect_to(root_path)
  end
end
