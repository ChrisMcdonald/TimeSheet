# # frozen_string_literal: true
#
# require 'test_helper'
#
# describe TravelsController do
#   let(:travel) { travels :one }
#
#   it 'gets index' do
#     get travels_url
#     value(response).must_be :success?
#   end
#
#   it 'gets new' do
#     get new_travel_url
#     value(response).must_be :success?
#   end
#
#   it 'creates travel' do
#     expect do
#       post travels_url, params: { travel: { od_finish: travel.od_finish, od_start: travel.od_start, project_id: travel.project_id, purpose: travel.purpose, time_sheet_id: travel.time_sheet_id, travel_date: travel.travel_date, user_id: travel.user_id } }
#     end.must_change 'Travel.count'
#
#     must_redirect_to travel_path(Travel.last)
#   end
#
#   it 'shows travel' do
#     get travel_url(travel)
#     value(response).must_be :success?
#   end
#
#   it 'gets edit' do
#     get edit_travel_url(travel)
#     value(response).must_be :success?
#   end
#
#   it 'updates travel' do
#     patch travel_url(travel), params: { travel: { od_finish: travel.od_finish, od_start: travel.od_start, project_id: travel.project_id, purpose: travel.purpose, time_sheet_id: travel.time_sheet_id, travel_date: travel.travel_date, user_id: travel.user_id } }
#     must_redirect_to travel_path(travel)
#   end
#
#   it 'destroys travel' do
#     expect do
#       delete travel_url(travel)
#     end.must_change 'Travel.count', -1
#
#     must_redirect_to travels_path
#   end
# end
