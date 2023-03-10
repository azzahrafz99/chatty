class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_status

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit :first_name, :last_name, :birthdate, :email,
               :password, :password_confirmation, :current_password, :avatar
    end
  end

  private

  def set_status
    current_user&.update!(status: User.statuses[:online])
  end
end
