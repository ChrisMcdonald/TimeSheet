class RemoveUserFromChatrooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatrooms, :user_id
  end
end
