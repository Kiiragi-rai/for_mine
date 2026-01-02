class Anniversary < ApplicationRecord
    validates :title, presence:  { message: "を入力してね" }
    validates :anniversary_date, presence:  { message: "を入力してね" }
end
