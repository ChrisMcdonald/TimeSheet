class AddCustomerStateToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :customer_state, :string
  end
end
