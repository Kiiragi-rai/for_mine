class CreateNotificationManagements < ActiveRecord::Migration[7.2]
  def change
    create_table :notification_managements do |t|
      t.references :notification_setting, foreign_key: true, null: false
      t.datetime :scheduled_for, null: false
      t.string :status, null: false
      t.datetime :sent_at
      t.string :error_message

      t.timestamps
    end
    add_index :notification_managements, [ :notification_setting_id, :scheduled_for ], unique: true, name: "index_notification_managements_unique_schedule"
  end
end
