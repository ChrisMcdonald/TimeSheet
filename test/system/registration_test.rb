# require "application_system_test_case"
# class UsersTest < ApplicationSystemTestCase
# 	include Devise::Test::IntegrationHelpers
# 	include Warden::Test::Helpers
# 	CHROME_DRIVER = if ENV['HEADLESS'] then
# 						:selenium_chrome_headless
# 					else
# 						:selenium_chrome
# 					end
# 	test 'register new user' do
# 		visit new_user_registration_path
# 		sleep 1
# 		fill_in 'user_first_name', with: 'first_name'
# 		fill_in 'user_last_name', with: 'last_name'
# 		fill_in 'user_email', with: 'user@email.com'
# 		fill_in 'user_password', with: 'Password'
# 		fill_in 'user_password_confirmation', with: 'Password'
# 		find('input[name=commit]').click
# 		sleep 1
# 		find_link(href: '/admin/sign_out').click
# 		sleep 1
# 		fill_in 'user_email', with: 'user@email.com'
# 		fill_in 'user_password', with: 'Password'
# 		find('input[name="commit"]').click
# 		sleep 1
# 	end
#
# end