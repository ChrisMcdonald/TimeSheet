# frozen_string_literal: true

class AddWorksReferenceToTimesheets < ActiveRecord::Migration[5.0]
  def change
    add_reference :time_sheets, :works, foreign_key: true
  end
end
