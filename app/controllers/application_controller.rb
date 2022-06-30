# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name ntust_department_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name ntust_department_id])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_root_path
  end
end
