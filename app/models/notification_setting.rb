# == Schema Information
#
# Table name: notification_settings
#
#  id                :bigint           not null, primary key
#  end_on            :date
#  frequency_days    :integer          default("everyday"), not null
#  is_enabled        :boolean          default(FALSE), not null
#  last_sent_on      :date
#  notification_hour :integer          default(0), not null
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
  has_many :notification_managements, dependent: :destroy

  validate :start_on_not_after_end_on

  enum :frequency_days, {
       everyday: 1, every_other_day: 2, every_5_days: 5, weekly: 7, bi_weekly: 14, thirty_days: 30
  }

  scope :is_enabled, -> { where(is_enabled: true) }

  def start_on_not_after_end_on
    return unless is_enabled
    return if start_on.blank?  ||  anniversary.anniversary_date.blank?

    next_anniversary = anniversary.next_anniversary
    # end onの方がいい？
    if start_on > next_anniversary
      errors.add(:start_on, "通知開始日は次の記念日以前に設定してください")
    end
  end

  def finished?
    end_on.present? && end_on <= Date.current
  end

  def reset_notification!
    update!(
      is_enabled: false,
      start_on: nil,
      end_on: nil,
      last_sent_on: nil
    )
  end

  def self.frequency_days_i18n
    frequency_days.keys.map do |key|
      [ I18n.t("activerecord.attributes.notification_setting.frequency_days.#{key}"), key ]
    end
  end
end
