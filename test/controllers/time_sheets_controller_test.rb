require 'test_helper'

class TimeSheetsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers


	setup do
		@time_sheet = time_sheets(:one)
		sign_in users(:one)
	end

  test "should get index" do

	  get time_sheets_url
    assert_response :success
  end

  test "should get new" do
    get new_time_sheet_url
    assert_response :success
  end

  test "should create time_sheet" do
    assert_difference('TimeSheet.count') do
      post time_sheets_url, params: { time_sheet: { time_period: Date.tomorrow } }
	end
  end

  test "should create time_sheet using current_day" do
	  assert_difference('TimeSheet.count') do
		  get current_day_path( Date.tomorrow)
	  end
 end

  test "should show time_sheet" do
    get time_sheet_url(@time_sheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_sheet_url(@time_sheet)
    assert_response :success
  end

  test "should update time_sheet" do
    patch time_sheet_url(@time_sheet), params: { time_sheet: { time_period: @time_sheet.time_period, user_id: @time_sheet.user_id } }
  end

  test "should destroy time_sheet" do
    assert_difference('TimeSheet.count', -1) do
      delete time_sheet_url(@time_sheet)
    end
  end
end
