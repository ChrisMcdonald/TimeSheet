# frozen_string_literal: true

json.extract! identity, :id, :provider, :username, :image, :created_at, :updated_at
json.url identity_url(identity, format: :json)
