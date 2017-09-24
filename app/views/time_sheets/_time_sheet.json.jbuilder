json.extract! time_sheet, :id, :time_period, :user_id, :created_at, :updated_at
json.url time_sheet_url(time_sheet, format: :json)