class AddNotificationOnToAnniversaries < ActiveRecord::Migration[7.2]
  def change
    add_column :anniversaries, :notification_on, :boolean,null: false, default: false
  end
end
