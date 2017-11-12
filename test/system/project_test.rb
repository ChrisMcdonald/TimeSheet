require "application_system_test_case"
class CustomerTest < ApplicationSystemTestCase
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
	setup do
		user = users(:one)
		user.add_role :admin
		sign_in user
		@routes = Rails.application.routes

	end
	after do
		Warden.test_reset!
	end


	test 'create a new project' do
		user = User.first

		visit root_path

		find_link(href: "/current_day/#{Date.today}").click
		find('a.add_fields').click
		first('input', class: 'hours-field').set(5)
		first('textarea', class: 'description-field').set('this is the description')
		find('input[name="commit"]').click

		visit projects_path

		find('#new-project').click
		within('#NewProject') do
			fill_in 'project_name', with: 'Project Two'

		end

		find('input[name="commit"]').click
		project = Project.last
		assert_equal project.name, 'Project Two'
		sleep 1
		find('.project-2').click
		sleep 1
		find('a', text: 'BACK').click
		sleep 1
		find('.project-1').click
		sleep 1
		find('button', text: 'CSV').click
		sleep 1
		sleep 1
	end

	test 'project csv' do
		project = Project.find(1)
		visit project_path(project)
		sleep 1
		find('button', text: 'CSV').click
		sleep 1
	end
	test 'project excel' do
		project = Project.find(1)
		visit project_path(project)
		sleep 1
		find('button', text: 'EXCEL').click
		sleep 1
	end
end