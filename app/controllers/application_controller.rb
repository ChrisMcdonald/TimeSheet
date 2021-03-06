# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue_from CanCan::AccessDenied, with: :user_not_authorized
  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/401.html", status: 401
  end

  private

  # def user_not_authorized
  #   flash[:alert] = 'You are not authorized to perform this action.'
  #   redirect_to user_session_path
  # end

  def set_time_zone
    Time.zone = 'Australia/Brisbane'
  end

  # def after_sign_in_path_for(resource)
  #   stored_location_for(resource) || welcome_path
  # end

  protected

  # def authenticate_user!
  #
  #   # redirect_to user_session_path, :notice => 'if you want to add a notice'
  #   if you want render 404 page
  #   render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
  #
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:password, :password_confirmation, :current_password, :email, :username, :first_name, :last_name, :street_no, :street, :city, :state,
                                                       :country, :post_code, :abn, :project_search, pay_rates_attributes: %i[id rate project_id _destroy]])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
