require "application_system_test_case"
class UsersTest < ApplicationSystemTestCase
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
	CHROME_DRIVER = if ENV['HEADLESS'] then
						:selenium_chrome_headless
					else
						:selenium_chrome
					end

	setup do
		@user = users(:one)
		@user.add_role :admin
		sign_in @user
		@routes = Rails.application.routes

	end
	after do
		Warden.test_reset!
	end


	test 'create a new User' do

		visit users_path
		find('#new-project').click
		# page.execute_script("  $('NewProject').slideToggle();")
		within('#NewProject') do
			fill_in 'user_first_name', with: 'bob'
			fill_in 'user_email', with: 'bob2@email.com'
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
		find('.pay_rate').set("23")

		# fill_in "user_pay_rates_attributes" ,with: 25
		find(".create-user").click
		# wait: 10
		page.execute_script("$('form#new-user').submit()")
		sleep 1
		user = User.last
		assert_equal 'bob', user.first_name
	end


end