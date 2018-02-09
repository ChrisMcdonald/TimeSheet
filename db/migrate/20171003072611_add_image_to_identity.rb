# frozen_string_literal: true

class AddImageToIdentity < ActiveRecord::Migration[5.0]
  def change
    add_column :identities, :image, :string
  end
end
