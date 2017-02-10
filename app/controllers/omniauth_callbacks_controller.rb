class OmniauthCallbacksController < Devise::OmniauthCallbacksController



  def all
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.present?
      sign_in_and_redirect @user, notice: "Signed In"
    else
      session['devices.user_attributes'] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all


  # def user_params
  #     params.require(:user).permit(
  #                                   :id,
  #                                   :email,
  #                                   :encrypted_password,
  #                                   :reset_password_token,
  #                                   :reset_password_sent_at,
  #                                   :remember_created_at,
  #                                   :sign_in_count,
  #                                   :current_sign_in_at,
  #                                   :last_sign_in_at,
  #                                   :created_at,
  #                                   :updated_at,
  #                                   :provider,
  #                                   :uid,
  #                                   :username,
  #                                   )
  #   end
end
# user.provider = auth.provider
# user.uid = auth.uid
# user.username = auth.info.nickname
# user.email = auth.info.email