# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # before_filter :authenticate_user!
  # helper_method :current_user

  def welcome_email(_user)
    @user = User.first
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
