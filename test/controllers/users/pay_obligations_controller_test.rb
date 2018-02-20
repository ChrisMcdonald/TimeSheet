require "test_helper"

describe User::PayObligationsController do
  let(:user_pay_obligation) {user_pay_obligations :one}
  let(:user) {users(:one)}
  it "gets index" do
    get user_pay_obligations_url users(:one)
    value(response).must_be :success?
  end

  it "gets new" do
    get new_user_pay_obligation_url users(:one)
    value(response).must_be :success?
  end

  it "creates user_pay_obligation" do
    expect {

      post user_pay_obligations_path(user), params: {user_pay_obligation: {holiday: user_pay_obligation.holiday, hourly_rate: user_pay_obligation.hourly_rate, superannuation: user_pay_obligation.superannuation, user_id: user_pay_obligation.user_id}}
    }.must_change "User::PayObligation.count"

    must_redirect_to user_pay_obligation_path(user, User::PayObligation.last)
  end

  it "shows user_pay_obligation" do
    get user_pay_obligation_url(user, user_pay_obligation)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_user_pay_obligation_url(user, user_pay_obligation)
    value(response).must_be :success?
  end

  it "updates user_pay_obligation" do

    patch user_pay_obligation_url(user_pay_obligation.user_id, user_pay_obligation), params: {user_pay_obligation: {holiday: user_pay_obligation.holiday, hourly_rate: user_pay_obligation.hourly_rate, superannuation: user_pay_obligation.superannuation, user_id: user.id}}
    must_redirect_to user_pay_obligation_path(user_pay_obligation)
  end

  it "destroys users_pay_obligation" do
    expect {
      delete user_pay_obligation_url(user, user_pay_obligation)
    }.must_change "User::PayObligation.count", -1

    must_redirect_to user_pay_obligations_path
  end
end
