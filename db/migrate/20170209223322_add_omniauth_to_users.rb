# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :user, :provider, :string
    add_column :user, :uid, :string
  end
end
