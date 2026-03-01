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

  attribute :end_on, :date


  validates :title, presence:  { message: "を入力してね" }, length: { maximum: 50 }
  validates :anniversary_date, presence:  { message: "を入力してね" }


  # validate :start_on_not_before_anniversary
  # validate :anniversary_date_not_after_today
  validate :not_accept_ten_years_later_start_on
  validate :start_on_not_before_today
  validate :anniversary_date_not_after_today
  validate :start_on_not_work_when_disable
  validate :start_on_required_when_enable

# today に変更
# 通知開始日は今日より前には追加できない
# 通知いらない　：開始時刻は入れられない

def start_on_not_work_when_disable
  return if is_enabled
  return if start_on.blank?

  errors.add(:start_on, "通知OFFのときは通知開始日は設定できません")
end

 def start_on_required_when_enable
  return unless is_enabled
  return if start_on.present?

  errors.add(:start_on, "通知ONの時は通知開始日が必要です")
 end


  def start_on_not_before_today
    return unless is_enabled
    return if start_on.blank?
    today = Date.current

    if start_on  < today
      errors.add(:start_on, "通知開始日は本日以降に設定してください")
    end
  end


  def anniversary_date_not_after_today
    return if anniversary_date.blank?
    today = Date.current

    if anniversary_date > today
      errors.add(:anniversary_date, "記念日は未来には設定できません")
    end
  end
  # １年後に変えてもいいんじゃない？
  def not_accept_ten_years_later_start_on
    return if start_on.blank?

    today = Date.current
    ten_years_later = today + 10.year

    if start_on > ten_years_later
      errors.add(:start_on, "通知開始日は１０年後以降に設定はできません")
    end
  end

  # validation:() 記念日　通知いる　　開始時刻

  # 通知いらない　：開始時刻は入れられない

  # last_sent_on 通知OFFなら削除


  def initialize(anniversary: nil, **attrs)
    @anniversary = anniversary
    @notification_setting =  @anniversary.notification_setting || @anniversary.build_notification_setting


    # editの時
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

    # sent_last
    #   end_on =  calculate(anniversary_date) 通知OFFなら　削除
    if is_enabled
      # notification_setting.end_on = calc_end_on(anniversary.anniversary_date)
      notification_setting.end_on = anniversary.next_anniversary

    else
      notification_setting.start_on = nil
      notification_setting.end_on = nil
      # JOB内で追加するようにする
      notification_setting.last_sent_on = nil
    end
  end

  private

  # 今年の記念日に変換　後できりわけお
  # def calc_end_on(anniversary_date)
  #   today = Date.current
  #   year = today.year
  #   mon = anniversary_date.month
  #   da = anniversary_date.day

  #   if mon == 2 && da == 29 && !Date.leap?(year)
  #     this_year = Date.new(year, 2, 28)
  #   else
  #     this_year =  Date.new(year, mon, da)
  #   end

  #   if this_year < today
  #     year += 1
  #     if mon == 2 && da == 29 && !Date.leap?(year)
  #        this_year = Date.new(year, 2, 28)
  #     else
  #       this_year = Date.new(year, mon, da)
  #     end
  #   end
  #     this_year
  # end

  # 閏年の記念日
end
