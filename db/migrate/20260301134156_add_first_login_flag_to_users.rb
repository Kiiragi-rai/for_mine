class AddFirstLoginFlagToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_login_flag, :boolean, default: false, null: false
  end
end
