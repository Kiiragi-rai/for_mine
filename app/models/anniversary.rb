# == Schema Information
#
# Table name: anniversaries
#
#  id               :bigint           not null, primary key
#  anniversary_date :date             not null
#  notification_on  :boolean          default(FALSE), not null
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
    validates :title, presence:  { message: "を入力してね" }
    validates :anniversary_date, presence:  { message: "を入力してね" }

    scope :notification_target_get, -> (date){ where(notification_on: true).where(anniversary_date: date)}  
end
