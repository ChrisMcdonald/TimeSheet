class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  helper_method :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :user_not_authorized


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
	redirect_to(redirect_to new_user_registration_url || edit_project_path) unless user_signed_in?
  end
  def set_time_zone
	  Time.zone = "Australia/Brisbane"
  end
  protected
  def configure_permitted_parameters

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :first_name, :last_name, :street_no, :street, :city, :state,
														 :country, :post_code, :abn, :project_search, pay_rates_attributes: [:id, :rate, :project_id, :_destroy]])
  end
end

