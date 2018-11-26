class AddFieldsToTimeSheets < ActiveRecord::Migration[5.1]
  def change
    add_column :time_sheets, :hour, :float
    add_column :time_sheets, :description, :string
    add_column :time_sheets, :date, :datetime
    add_reference :time_sheets, :projects, foreign_key: true
    add_reference :time_sheets, :invoices, foreign_key: true


  end
end
