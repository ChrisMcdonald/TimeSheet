class ProfileController < ApplicationController
  before_filter :authenticate_user!
  helper_method :current_user
  def index

  end

  def send_email
    UserMailer.welcome_email(@user).deliver

  end
end
