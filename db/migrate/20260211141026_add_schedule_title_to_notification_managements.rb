class AddScheduleTitleToNotificationManagements < ActiveRecord::Migration[7.2]
  def change
    add_column :notification_managements, :schedule_title, :string
  end
end
