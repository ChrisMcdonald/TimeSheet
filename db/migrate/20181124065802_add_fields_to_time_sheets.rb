class AddFieldsToTimeSheets < ActiveRecord::Migration[5.1]
  def change
    add_column :time_sheets, :hour, :float
    add_column :time_sheets, :description, :string
    add_column :time_sheets, :date, :datetime
    add_reference :time_sheets, :project, foreign_key: true
    add_reference :time_sheets, :invoice, foreign_key: true


  end
end
