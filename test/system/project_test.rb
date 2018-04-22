
require 'application_system_test_case'
class ProjectTest < ApplicationSystemTestCase
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
    # user = User.first

    visit root_path
    date = Date.today.iso8601
    find_link(href: "/current_day/#{date}").click
    find('a', class: 'add_fields').click
    first('input', class: 'hours-field').set(5)
    first('textarea', class: 'description-field').set('this is the description')
    find('input[name="commit"]').click

    visit projects_path

    find('#new-project').click
    within('#NewProject') do
      fill_in 'project_name', with: 'Projectone'
    end

    find('input[name="commit"]').click
    project2 = projects(:two)
    project1 = projects(:one)
    assert_equal project1.name, 'Projectone'
    find(".project-#{project2.id}").click
    find('a', text: 'BACK').click
    find(".project-#{project1.id}").click
    find('button', text: 'CSV').click
  end

  test 'project csv' do
    project = projects(:one)
    visit project_path(project)
    sleep 1
    find('button', text: 'CSV').click
    sleep 1
  end
  test 'project excel' do
    project = projects(:one)
    visit project_path(project)
    sleep 1
    find('button', text: 'EXCEL').click
    sleep 1
  end
end
