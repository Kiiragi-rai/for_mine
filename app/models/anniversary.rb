# == Schema Information
#
# Table name: anniversaries
#
#  id               :bigint           not null, primary key
#  anniversary_date :date             not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_anniversaries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Anniversary < ApplicationRecord
    include Hashid::Rails

    belongs_to :user
    has_one :notification_setting, dependent: :destroy


    validates :title, presence:  { message: "を入力してね" }
    validates :anniversary_date, presence:  { message: "を入力してね" }


    scope :notification_target_get, ->(date) { where(notification_on: true).where(anniversary_date: date) }
    scope :notification_enabled, -> { joins(:notification_setting).where(notification_settings: { is_enabled: true }) }
    #  scope :notification_enables , ->{ joins(:notification_setting).where('notification_settings.is_enabled = ?','true')}
    #  scope :notification_target_in_range, -> { joins(:notification_setting).where('notification_settings.start_on <= ?', Date.current).where('anniversary.anniversary_date >= ?', Date.current) }
    #  scope :notification_target_in_range, -> { joins(:notification_setting).where(notification_settings: {start_on: ..Date.current}) }


    # 記念日経過
    def anniversary_calculate
      # ゴーr 記念日からどれくらいったか
      today = Date.current
     diff =  (anniversary_date - today).to_i
     if diff == 0
        "今日が記念日"
     else diff < 0
        "記念日から#{diff.abs}日経ちました"
       # 今日より後ならダメ　何にも出ないよ
     end
    end


    # カレンダー用
    def start_time
      # next_anniversary
      anniversary_date
    end

    def self.ransackable_attributes(auth_object = nil)
      [ "anniversary_date", "title" ]
    end
    def self.ransackable_associations(auth_object = nil)
      [ "notification_setting", "user" ]
    end

    # 次に来る記念日計算
    def next_anniversary
      today = Date.current
      year = today.year
      mon = anniversary_date.month
      da = anniversary_date.day

      this_year = anniversary_date_for_year(year: year, month: mon, day: da)

      if this_year <= today
        anniversary_date_for_year(year: year + 1, month: mon, day: da)
      else
        this_year
      end
    end

private
    # 閏年確認
    def anniversary_date_for_year(year:, month:, day:)
      if month == 2 && day == 29 && !Date.leap?(year)
         Date.new(year, 2, 28)
      else
        Date.new(year, month, day)
      end
    end
end
