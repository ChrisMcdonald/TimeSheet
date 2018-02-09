# frozen_string_literal: true

json.extract! user, :id, :email, :username, :first_name, :last_name, :street_no, :street, :city, :state, :country, :post_code, :abn, :created_at, :updated_at
json.url user_url(user, format: :json)
