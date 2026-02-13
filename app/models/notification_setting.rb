# == Schema Information
#
# Table name: notification_settings
#
#  id                :bigint           not null, primary key
#  end_on            :date
#  frequency_days    :integer          default("everyday"), not null
#  is_enabled        :boolean          default(FALSE), not null
#  last_sent_on      :date
#  notification_time :time
#  start_on          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  anniversary_id    :bigint           not null
#
# Indexes
#
#  index_notification_settings_on_anniversary_id  (anniversary_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (anniversary_id => anniversaries.id)
#
class NotificationSetting < ApplicationRecord
  belongs_to :anniversary
  has_many :notification_managements

  enum :frequency_days, {
       everyday: 1, every_other_day: 2, every_5_days: 5, weekly: 7
  }

  scope :is_enabled, -> { where(is_enabled: true) }
end
