require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
  setup do
	  sign_in users(:one)

	  @work = works(:one)
  end

  test "should get index" do
    get works_url
    assert_response :success
  end

  test "should get new" do
    get new_work_url
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post works_url, params: { work: { date: @work.date, description: @work.description, hour: @work.hour, project_id: @work.project_id, time_sheet_id: @work.time_sheet_id } }
    end

    assert_redirected_to work_url(Work.last)
  end

  test "should show work" do
    get work_url(@work)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_url(@work)
    assert_response :success
  end

  test "should update work" do
    patch work_url(@work), params: { work: { date: @work.date, description: @work.description, hour: @work.hour, project_id: @work.project_id, time_sheet_id: @work.time_sheet_id } }
    assert_redirected_to work_url(@work)
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete work_url(@work)
    end

    assert_redirected_to works_url
  end
end
