json.extract! customer, :id, :first_name, :last_name, :street_no, :street, :city, :state, :country, :post_code, :abn, :created_at, :updated_at
json.url customer_url(customer, format: :json)