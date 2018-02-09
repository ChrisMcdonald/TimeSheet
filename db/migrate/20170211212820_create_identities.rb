# frozen_string_literal: true

class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :identities do |t|
      t.integer :user_id
      t.integer :uid
      t.string :provider
      t.string :token
      t.string :secrect
      t.datetime :created_at
      t.datetime :updated_at
      t.string :profile_page

      t.timestamps
    end
  end
end
