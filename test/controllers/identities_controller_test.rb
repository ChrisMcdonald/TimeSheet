require 'test_helper'

class IdentitiesControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
  setup do
  sign_in users(:one)
    @identity = identities(:one)
  end


  #
  # test "should get new" do
  #   get new_identity_url
  #   assert_response :success
  # end

  # test "should create identity" do
  #   assert_difference('Identity.count') do
  #     post identities_url, params: { identity: { image: @identity.image, provider: @identity.provider} }
  #   end
  #
  #   assert_redirected_to identity_url(Identity.last)
  # end
  #
  # test "should show identity" do
  #   get identity_url(@identity)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_identity_url(@identity)
  #   assert_response :success
  # end

  # test "should update identity" do
  #   patch identity_url(@identity), params: { identity: {  provider: @identity.provider } }#, username: @identity.username
  #   assert_redirected_to identity_url(@identity)
  # end
  #
  # test "should destroy identity" do
  #   assert_difference('Identity.count', -1) do
  #     delete identity_url(@identity)
  #   end

    # assert_redirected_to identities_url
  # end
end
