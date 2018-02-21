class CreateUserPayObligations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pay_obligations do |t|
      t.decimal :superannuation, precision: 5, scale: 2
      t.decimal :holiday, precision: 5, scale: 2
      t.decimal :hourly_rate, precision: 5, scale: 2
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
