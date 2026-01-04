class Anniversary < ApplicationRecord
    validates :title, presence:  { message: "を入力してね" }
    validates :anniversary_date, presence:  { message: "を入力してね" }

    scope :notification_target_get, -> (date){ where(notification_on: true).where(anniversary_date: date)}  
end
