class CreateNotificationSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :notification_settings do |t|
      t.references :anniversary, null: false, foreign_key: true, index: { unique: true}
      t.boolean :is_enabled, null: false, default: false
      t.date :start_on
      t.time :notification_time
      t.integer :frequency_days, null: false, default: 1
      t.date :last_sent_on

      t.timestamps
    end
  end
end
