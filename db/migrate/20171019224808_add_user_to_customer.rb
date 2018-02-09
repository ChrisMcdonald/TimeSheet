# frozen_string_literal: true

class AddUserToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :user, foreign_key: true
  end
end
