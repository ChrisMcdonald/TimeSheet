# frozen_string_literal: true

class RemoveWorksFromTimeSheets < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_sheets, :works_id, :integer
  end
end
