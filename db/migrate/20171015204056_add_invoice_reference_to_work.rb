class AddInvoiceReferenceToWork < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :invoice, index: true, foreign_key: true, unique: true
  end
end
