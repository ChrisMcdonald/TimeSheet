# frozen_string_literal: true

class AddTravelDateToTravels < ActiveRecord::Migration[5.1]
  def change
    add_column :travels, :travel_date, :date
  end
end
