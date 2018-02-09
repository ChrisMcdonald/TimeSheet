# frozen_string_literal: true

class AddVehicleReferenceToTravel < ActiveRecord::Migration[5.1]
  def change
    add_reference :travels, :vehicle, foreign_key: true
  end
end
