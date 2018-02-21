# frozen_string_literal: true

class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :user, :username, :string
  end
end
