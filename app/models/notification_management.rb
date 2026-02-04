# == Schema Information
#
# Table name: notification_managements
#
#  id                      :bigint           not null, primary key
#  error_message           :string
#  scheduled_for           :datetime         not null
#  sent_at                 :datetime
#  status                  :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  notification_setting_id :bigint           not null
#
# Indexes
#
#  index_notification_managements_on_notification_setting_id  (notification_setting_id)
#  index_notification_managements_unique_schedule             (notification_setting_id,scheduled_for) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (notification_setting_id => notification_settings.id)
#
class NotificationManagement < ApplicationRecord
  belongs_to: notification_setting

  # status success, failure enumかな、それか直接入れる　

  validates :schedule_for, presece: true
  validates :status, presence: true
end
