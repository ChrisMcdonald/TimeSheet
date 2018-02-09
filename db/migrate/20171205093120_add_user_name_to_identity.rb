# frozen_string_literal: true

class AddUserNameToIdentity < ActiveRecord::Migration[5.1]
  def change
    add_column :identities, :username, :string
  end
end
