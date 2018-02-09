# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :name
      t.date :endOfFortnight
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
