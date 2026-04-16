class ChangeStatusNullOnNotificationManagements < ActiveRecord::Migration[7.2]
  def change
    change_column_null :notification_managements, :status, true
  end
end
