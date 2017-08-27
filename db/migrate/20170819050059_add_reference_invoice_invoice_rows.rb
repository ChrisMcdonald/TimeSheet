class AddReferenceInvoiceInvoiceRows < ActiveRecord::Migration[5.0]
  def change
	  add_reference :invoice_rows, :invoice, foreign_key: true
  end
end
