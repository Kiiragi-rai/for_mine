class RemoveIsDeletedFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :is_deleted, :boolean
  end
end
