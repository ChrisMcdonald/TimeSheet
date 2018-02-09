# frozen_string_literal: true

class AddDetailToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :owner_first_name, :string
    add_column :invoices, :owner_last_name, :string
    add_column :invoices, :owner_email, :string
    add_column :invoices, :owner_street_no, :string
    add_column :invoices, :owner_street, :string
    add_column :invoices, :owner_city, :string
    add_column :invoices, :owner_country, :string
    add_column :invoices, :owner_post_code, :string
    add_column :invoices, :owner_abn, :string
    add_column :invoices, :customer_first_name, :string
    add_column :invoices, :customer_last_name, :string
    add_column :invoices, :customer_email, :string
    add_column :invoices, :customer_street_no, :string
    add_column :invoices, :customer_street, :string
    add_column :invoices, :customer_city, :string
    add_column :invoices, :customer_country, :string
    add_column :invoices, :customer_post_code, :string
    add_column :invoices, :customer_abn, :string
  end
end
