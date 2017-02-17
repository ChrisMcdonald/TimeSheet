class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!



  def all
    user = User.from_omniauth(request.env["omniauth.auth"] ,current_user)
    # sign_in(:user, @user)#, :event => :authentication #this will throw if @user is not activated

    if user.present?
      sign_in_and_redirect user, notice: "Signed In"
    else
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :google, :all

end
# user.provider = auth.provider
# user.uid = auth.uid
# user.username = auth.info.nickname
# user.email = auth.info.email