class AnniversaryNotificationSettingForm
  include ActiveModel::API
  include ActiveModel::Attributes

  attr_reader :anniversary, :notification_setting

  attribute :title, :string
  attribute :anniversary_date, :date
  attribute :is_enabled, :boolean
  attribute :frequency_days, :integer
  attribute :notification_time, :time
  attribute :start_on, :date


  validates :title, presence:  { message: "を入力してね" },length: { maximum: 50}
  validates :anniversary_date, presence:  { message: "を入力してね" }
  

  # validate :start_on_not_before_anniversary
  # validate :anniversary_date_not_after_today
  validate :not_accept_ten_years_later_start_on
  

  # def start_on_not_before_anniversary
  #   return if start_on.blank? || anniversary_date.blank?

  #   if start_on > anniversary_date
  #     errors.add(:start_on, "通知開始日は記念日より前にしか")
  #   end
  # end

  # def anniversary_date_not_after_today
  #   return if anniversary_date.blank?
  #   today = Date.current

  #   if anniversary_date > today
  #     errors.add(:anniversary_date, "記念日は未来には設定できません")
  #   end
  # end

  def not_accept_ten_years_later_start_on
    return if start_on.blank?

    today = Date.current
    ten_years_later = today + 10.year

    if start_on > ten_years_later 
      errors.add(:start_on, "通知開始日は１０年後以降に設定はできません")
    end

  end


  def initialize( anniversary: nil,**attrs)
    @anniversary = anniversary
    @notification_setting =  @anniversary.notification_setting || @anniversary.build_notification_setting


 #editの時
    defaults ={
      title: @anniversary.title,
      anniversary_date: @anniversary.anniversary_date,
      is_enabled: @notification_setting.is_enabled,
      notification_time: @notification_setting.notification_time,
      start_on: @notification_setting.start_on,
      frequency_days: @notification_setting.frequency_days
    }

    super(defaults.merge(attrs))
  end

  def save
    return false unless valid?

    transfer_attributes

    ApplicationRecord.transaction do
     anniversary.save!
     notification_setting.save!
    end

    true

  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  # DB保存用
  def transfer_attributes
    anniversary.title = title
    anniversary.anniversary_date = anniversary_date
    notification_setting.is_enabled = is_enabled
    notification_setting.frequency_days = frequency_days
    notification_setting.start_on = start_on
    notification_setting.notification_time = notification_time
  end
end
