class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  helper_method :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || edit_project_path)
  end
  def set_time_zone
	  Time.zone = "Australia/Brisbane"
  end
  protected
  def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :first_name, :last_name, :street_no, :street, :city, :state, :country, :post_code, :abn,:password_confirmation,:password, :current_password])
  end
end

