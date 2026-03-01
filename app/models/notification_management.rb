# == Schema Information
#
# Table name: notification_managements
#
#  id                      :bigint           not null, primary key
#  error_message           :string
#  schedule_title          :string
#  scheduled_for           :datetime         not null
#  sent_at                 :datetime
#  status                  :integer          default("pending"), not null
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
  belongs_to :notification_setting

  # status success, failure enumかな、それか直接入れる
  enum  status: {
    pending: 0,
    success: 1,
    failure: 2
  }

  validates :scheduled_for, presence: true

  def self.create_for(target)
    find_or_create_by(
        notification_setting_id: target.notification_setting_id,
        scheduled_for: target.scheduled_for
      ) do |management|
        management.schedule_title = target.title
      end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["notification_setting"]
  end

end
