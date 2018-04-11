class AddGitNameToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :gitname, :string
  end
end
