# frozen_string_literal: true

class AddDetailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :user, :first_name, :string
    add_column :user, :last_name, :string
    add_column :user, :street_no, :string
    add_column :user, :street, :string
    add_column :user, :city, :string
    add_column :user, :state, :string
    add_column :user, :country, :string
    add_column :user, :post_code, :string
    add_column :user, :abn, :string
  end
end
