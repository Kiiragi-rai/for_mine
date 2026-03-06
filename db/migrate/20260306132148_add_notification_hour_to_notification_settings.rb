class AddNotificationHourToNotificationSettings < ActiveRecord::Migration[7.2]
  def up
    add_column :notification_settings, :notification_hour, :integer

    execute <<~SQL
      UPDATE notification_settings
      SET notification_hour = EXTRACT(HOUR FROM notification_time)
      WHERE notification_time IS NOT NULL
    SQL
  end

  def down 
    remove_column :notification_settings, :notification_hour
  end
end
