class AddColumsToTimeSheet < ActiveRecord::Migration[5.0]
  def change
    add_column :time_sheets, :hour, :integer
    add_column :time_sheets, :description, :string
  end
end
