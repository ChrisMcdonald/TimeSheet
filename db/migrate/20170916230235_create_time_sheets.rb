class CreateTimeSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheets do |t|
      t.date :time_period
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
