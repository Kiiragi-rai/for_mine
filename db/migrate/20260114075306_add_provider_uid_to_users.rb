class AddProviderUidToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string, null: false, default: ""
    add_column :users, :uid, :string, null: false, default: ""

    add_index :users, [:provider, :uid], unique: true
  end
end
