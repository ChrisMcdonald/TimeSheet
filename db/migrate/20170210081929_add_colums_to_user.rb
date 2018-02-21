# frozen_string_literal: true

class AddColumsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :user, :oauth_token, :string
    add_column :user, :oauth_expires_at, :datetime
  end
end
