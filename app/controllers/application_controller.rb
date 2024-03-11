class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])
  end


  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_index_path
    elsif resource.customer?
      customer_path(resource.id)
    else
      '/users/edit'
    end
  end

  def after_update_path_for(resource)
    if resource.admin?
      admin_index_path
    elsif resource.customer?
      customer_path(resource.id)
    else
      '/users/edit'
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :role,
      :password,
      :password_confirmation,
      :current_password
    )
  end
end
