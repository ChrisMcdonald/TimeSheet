# frozen_string_literal: true

class CreatePayRates < ActiveRecord::Migration[5.0]
  def change
    create_table :pay_rates do |t|
      t.integer :rate
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
