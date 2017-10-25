require "test_helper"

describe PayRatesController do
  let(:pay_rate) { pay_rates :one }

  it "gets index" do
    get pay_rates_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_pay_rate_url
    value(response).must_be :success?
  end

  it "creates pay_rate" do
    expect {
      post pay_rates_url, params: { pay_rate: { project_id: pay_rate.project_id, rate: pay_rate.rate, user_id: pay_rate.user_id } }
    }.must_change "PayRate.count"

    must_redirect_to pay_rate_path(PayRate.last)
  end

  it "shows pay_rate" do
    get pay_rate_url(pay_rate)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_pay_rate_url(pay_rate)
    value(response).must_be :success?
  end

  it "updates pay_rate" do
    patch pay_rate_url(pay_rate), params: { pay_rate: { project_id: pay_rate.project_id, rate: pay_rate.rate, user_id: pay_rate.user_id } }
    must_redirect_to pay_rate_path(pay_rate)
  end

  it "destroys pay_rate" do
    expect {
      delete pay_rate_url(pay_rate)
    }.must_change "PayRate.count", -1

    must_redirect_to pay_rates_path
  end
end
