class AnniversaryNotificationSettingForm
  include ActiveModel::API
  include ActiveModel::Attributes

  attr_reader :anniversary, :notification_setting

  attribute :title, :string
  attribute :anniversary_date, :date
  attribute :is_enabled, :boolean
  attribute :frequency_days, :string
  attribute :notification_hour, :integer
  attribute :start_on, :date

  attribute :end_on, :date


  validates :title, presence:  { message: "を入力してね" }, length: { maximum: 50 }
  validates :anniversary_date, presence:  { message: "を入力してね" }


  # validate :start_on_not_before_anniversary
  # validate :anniversary_date_not_after_today
  validate :not_accept_one_years_later_start_on
  validate :start_on_not_before_today
  validate :anniversary_date_not_after_today
  validate :start_on_not_work_when_disable
  validate :start_on_required_when_enable
  validate :start_on_not_after_end_on
# validate :start_on_must_anniversary_date
# validate :start_on_not_after_next_anniversary



# 通知OFFの時通知開始日設定できない
def start_on_not_work_when_disable
  return if is_enabled
  return if start_on.blank?

  errors.add(:start_on, ": 通知がOFFのときは開始日は設定できないよ😊")
end
 # 通知ONでは通知開始日が必要
 def start_on_required_when_enable
  return unless is_enabled
  return if start_on.present?

  errors.add(:start_on, ": 通知をONにしたら開始日を選んでね😊")
 end

  #  通知開始日と時刻の設定が一時間以上空いている
  def start_on_not_before_today
    return unless is_enabled
    return if start_on.blank? || notification_hour.blank?

    start_time = Time.zone.local(
      start_on.year,
      start_on.month,
      start_on.day,
      notification_hour
    )

    if start_time  < Time.current + 1.hour
      errors.add(:start_on, ": 通知は今から1時間後以降に設定してね😊")
    end
  end

  # 記念日は未来に設定できない
  def anniversary_date_not_after_today
    return if anniversary_date.blank?
    today = Date.current

    if anniversary_date > today
      errors.add(:anniversary_date, ": 記念日は今日までの日付で設定してね😊")
    end
  end
  # 通知開始日は一年以内
  def not_accept_one_years_later_start_on
    return if start_on.blank?

    today = Date.current
    one_year_later = today + 1.year

    if start_on >  one_year_later
      errors.add(:start_on, ": 通知開始日は1年以内で設定してね😊")
    end
  end

  # startonはendonよりあとの日付では登録できない
  def start_on_not_after_end_on
    return unless is_enabled
    return if start_on.blank?  ||  anniversary.anniversary_date.blank?

    next_anniversary = anniversary.next_anniversary
    # end onの方がいい？
    if start_on > next_anniversary
      errors.add(:start_on, ": 通知開始日は次の記念日以前に設定してください")
    end
  end

  #  def start_on_must_anniversary_date
  #   # anniversary_dateはからならstart_onはONにできない
  #   return unless is_enabled

  #   if annviersary_date.blank?
  #     errors.add(:anniversary_date, "記念日を入力してください")
  #   end
  #  end



  # # validation:() 記念日　通知いる　　開始時刻

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
      notification_hour: @notification_setting.notification_hour,
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
   puts "DEBUG frequency_days: #{frequency_days.inspect} (#{frequency_days.class})"
    notification_setting.start_on = start_on
    notification_setting.notification_hour = notification_hour

    # sent_last
    #   end_on =  calculate(anniversary_date) 通知OFFなら　削除
    if is_enabled
      # notification_setting.end_on = calc_end_on(anniversary.anniversary_date)
      # 次の記念日
      notification_setting.end_on = anniversary.next_anniversary

    else
      notification_setting.start_on = nil
      notification_setting.end_on = nil
      # JOB内で追加するようにする
      notification_setting.last_sent_on = nil
    end
  end

  # private

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
