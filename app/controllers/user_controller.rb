class UserController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :first_name, :last_name, :street_no, :street, :city, :state, :password, :password_confirmation, :success,
                                 :start_date, :end_date, :country, :post_code, :abn, :project_search, pay_rates_attributes: %i[id rate project_id _destroy])
  end
end
