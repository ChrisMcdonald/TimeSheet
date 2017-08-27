class CreateInvoiceRows < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_rows do |t|
      t.float :rate
      t.float :hours
	  t.references :project, index:true

      t.timestamps
    end
  end
end
