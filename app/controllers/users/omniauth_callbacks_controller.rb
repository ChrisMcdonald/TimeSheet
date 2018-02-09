# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # before_action :authenticate_user!
  skip_authorize_resource

  def all
    auth = request.env['omniauth.auth']
    identity = User.from_omniauth(auth, current_user)
    if user_signed_in?
      flash[:notice] = if current_user != identity.user
                         'Account is registered to another user'
                       else
                         'Account Added'
                       end
      redirect_to user_identities_path(current_user)

    elsif identity.user.present?
      sign_in_and_redirect identity.user
      flash[:notice] = "Signed in as #{identity.user.username} "

    else
      # session['user'] = user.id
      redirect_to new_user_session_path
      flash[:notice] = 'Account Not Found'
    end
  end
  alias facebook all
  alias google all
end
# user.provider = auth.provider
# user.uid = auth.uid
# user.username = auth.info.nickname
# user.email = auth.info.email
