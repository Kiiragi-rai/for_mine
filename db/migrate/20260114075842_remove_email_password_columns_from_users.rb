class RemoveEmailPasswordColumnsFromUsers < ActiveRecord::Migration[7.2]
  def change
      remove_index :users, :email if index_exists?(:users, :email)
      remove_index :users, :reset_password_token if index_exists?(:users, :reset_password_token)
  
      remove_column :users, :email, :string
      remove_column :users, :encrypted_password, :string
      remove_column :users, :reset_password_token, :string
      remove_column :users, :reset_password_sent_at, :datetime
      remove_column :users, :remember_created_at, :datetime
  end
end
