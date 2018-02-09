# frozen_string_literal: true

json.extract! work, :id, :date, :hour, :description, :project_id, :time_sheet_id, :created_at, :updated_at
json.url work_url(work, format: :json)
