# frozen_string_literal: true

class AddUsernameToInvoiceRow < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_rows, :username, :string
  end
end
