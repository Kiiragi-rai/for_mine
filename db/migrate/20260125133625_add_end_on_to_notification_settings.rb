class AddEndOnToNotificationSettings < ActiveRecord::Migration[7.2]
  def change
    add_column :notification_settings, :end_on, :date
  end
end
