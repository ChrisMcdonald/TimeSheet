# frozen_string_literal: true

class AddOwnerStateToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :owner_state, :string
  end
end
