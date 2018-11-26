
require 'application_system_test_case'
class ProjectTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers


  test 'create a new project' do
    user = users(:usersone)

    sign_in user
    visit projects_path
    sleep 1
    find('#new-project').click
    within('#NewProject') do
      fill_in 'project_name', with: 'Projectone'
    end

    find('input[name="commit"]').click
    project2 = projects(:projectstwo)
    project1 = projects(:projectsone)
    assert_equal project1.name, 'Projectone'
    find(".project-#{project2.id}").click
    find('a', text: 'BACK').click
    find(".project-#{project1.id}").click
    find('button', text: 'CSV').click
  end

  test 'project csv' do
    project = projects(:projectsone)
    visit project_path(project)
    find('button', text: 'CSV').click
  end
  test 'project excel' do
    project = projects(:projectsone)
    visit project_path(project)
    find('button', text: 'EXCEL').click
  end
end
