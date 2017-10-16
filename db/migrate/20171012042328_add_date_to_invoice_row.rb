class AddDateToInvoiceRow < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_rows, :date, :date
  end
end
