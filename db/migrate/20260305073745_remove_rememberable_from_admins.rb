class RemoveRememberableFromAdmins < ActiveRecord::Migration[7.2]
  def change
    remove_column :admins, :remember_created_at, :datetime
  end
end
