require "application_system_test_case"
class UsersTest < ApplicationSystemTestCase
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
	setup do
		sign_in users(:one)
		@routes = Rails.application.routes

	end
	after do
		Warden.test_reset!
	end


	test 'create a new User' do
		user = User.first
		user.add_role :admin
		visit users_path

		page.execute_script("  $('NewProject').slideToggle();")
		within('#NewProject') do
			fill_in 'user_first_name', with: 'bob'
			fill_in 'user_email', with: 'bob@email.com'
			fill_in 'user_password', with: 'password'
			fill_in 'user_password_confirmation', with: 'password'
			fill_in 'user_last_name', with: 'smith'
			fill_in 'user_street_no', with: 1
			fill_in 'user_street', with: 'street'
			fill_in 'user_state', with: 'state'
			fill_in 'user_city', with: 'city'
			fill_in 'user_country', with: 'country'
			fill_in 'user_post_code', with: 4000
			fill_in 'user_abn', with: 1223456
		end
		find('a.add_fields').click
		fill_in "user[pay_rate_attributes][/[0-9]/][rate]", with: 25

		# find('input[name="commit"]').click
		user = User.find_by(first_name: 'bob')
		assert_equal 'bob', user
	end

end