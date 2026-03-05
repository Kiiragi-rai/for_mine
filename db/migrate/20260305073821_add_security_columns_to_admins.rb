class AddSecurityColumnsToAdmins < ActiveRecord::Migration[7.2]
  def change
        # lockable
        add_column :admins, :failed_attempts, :integer, default: 0, null: false
        add_column :admins, :locked_at, :datetime
        # trackable
        add_column :admins, :sign_in_count, :integer, default: 0, null: false
        add_column :admins, :current_sign_in_at, :datetime
        add_column :admins, :last_sign_in_at, :datetime
        add_column :admins, :current_sign_in_ip, :string
        add_column :admins, :last_sign_in_ip, :string
  end
end
