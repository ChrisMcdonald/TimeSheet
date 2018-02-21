class CreateUserPayObligations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pay_obligations do |t|
      t.decimal :superannuation
      t.decimal :holiday
      t.decimal :hourly_rate
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
