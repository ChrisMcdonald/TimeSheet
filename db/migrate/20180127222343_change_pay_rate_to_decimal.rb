# frozen_string_literal: true

class ChangePayRateToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :pay_rates, :rate, :decimal
  end
end
