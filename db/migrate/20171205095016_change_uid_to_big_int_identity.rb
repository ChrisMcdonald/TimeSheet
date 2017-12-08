class ChangeUidToBigIntIdentity < ActiveRecord::Migration[5.1]
  change_column :identities, :uid, :string
end
