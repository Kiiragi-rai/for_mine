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


    def anniversary_calculate
      # ゴーr 記念日からどれくらいったか
      today = Date.current
     diff =  (anniversary_date - today ).to_i
     if diff == 0
        "今日が記念日"
     else diff < 0 
        "記念日から#{diff.abs}日経ちました"
     end
    end
end
