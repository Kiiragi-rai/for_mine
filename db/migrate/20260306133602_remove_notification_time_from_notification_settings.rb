class RemoveNotificationTimeFromNotificationSettings < ActiveRecord::Migration[7.2]
  def change
    remove_column :notification_settings, :notification_time, :time
  end
end
