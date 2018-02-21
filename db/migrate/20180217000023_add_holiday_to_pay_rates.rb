class AddHolidayToPayRates < ActiveRecord::Migration[5.1]
  def change
    add_column :pay_rates, :holiday, :decimal
    add_column :pay_rates, :superannuation, :decimal
    add_column :pay_rates, :date, :datetime
  end
end
