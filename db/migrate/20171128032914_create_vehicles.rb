# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :rego_no

      t.timestamps
    end
  end
end
