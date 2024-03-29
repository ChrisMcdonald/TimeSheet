# frozen_string_literal: true

class CreateTravels < ActiveRecord::Migration[5.1]
  def change
    create_table :travels do |t|
      t.integer :od_start
      t.integer :od_finish
      t.string :purpose
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.references :travel, foreign_key: true

      t.timestamps
    end
  end
end
