class AddEmailToIdentity < ActiveRecord::Migration[5.1]
  def change
    add_column :identities, :email, :string
  end
end
