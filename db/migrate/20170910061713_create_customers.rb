# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_no
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :post_code
      t.string :abn

      t.timestamps
    end
  end
end
