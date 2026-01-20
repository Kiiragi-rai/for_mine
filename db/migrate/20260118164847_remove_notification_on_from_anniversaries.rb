class RemoveNotificationOnFromAnniversaries < ActiveRecord::Migration[7.2]
  def change
    remove_column :anniversaries, :notification_on, :boolean
  end
end
