# frozen_string_literal: true

class CreateChatrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chatrooms do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
