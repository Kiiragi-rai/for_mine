# == Schema Information
#
# Table name: notification_settings
#
#  id                :bigint           not null, primary key
#  frequency_days    :integer          default(1), not null
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

  
end
