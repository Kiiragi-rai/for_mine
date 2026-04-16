class ChangeStatusToIntegerInNotificationManagements < ActiveRecord::Migration[7.2]
  def change
    change_column :notification_managements,
    :status,
    :integer,
    using: '0',
    default: 0,
    null: false
  end
end
