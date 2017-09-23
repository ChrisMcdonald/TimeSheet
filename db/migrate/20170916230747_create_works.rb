class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.date :date
      t.integer :hour
      t.string :description
      t.references :project, foreign_key: true
      t.references :time_sheet, foreign_key: true

      t.timestamps
    end
  end
end
