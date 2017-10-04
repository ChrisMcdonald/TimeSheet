class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || edit_project_path)
  end
  def set_time_zone
	  Time.zone = "Australia/Brisbane"
  end

end
