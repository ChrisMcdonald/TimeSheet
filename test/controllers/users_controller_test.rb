require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
  setup do
	  sign_in users(:one)
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end
  #
  # test "should create user" do
  #   assert_difference('User.count') do
  #     post users_url, params: { user: { abn: @user.abn, city: @user.city, country: @user.country, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, post_code: @user.post_code, state: @user.state, street: @user.street, street_no: @user.street_no, username: @user.username } }
  #   end
  #
  #   assert_redirected_to user_url(User.last)
  # end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { abn: @user.abn, city: @user.city, country: @user.country, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, post_code: @user.post_code, state: @user.state, street: @user.street, street_no: @user.street_no, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
