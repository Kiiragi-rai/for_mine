class ChangeNotificationHourOnNotificationSettings < ActiveRecord::Migration[7.2]
  def change
    execute <<~SQL
      UPDATE notification_settings
      SET notification_hour = 0
      WHERE notification_hour IS NULL
    SQL

    # default設定
    change_column_default :notification_settings, :notification_hour, 0

    # null禁止
    change_column_null :notification_settings, :notification_hour, false
  end
end
