# frozen_string_literal: true

json.extract! pay_rate, :id, :rate, :project_id, :user_id, :created_at, :updated_at
json.url pay_rate_url(pay_rate, format: :json)
