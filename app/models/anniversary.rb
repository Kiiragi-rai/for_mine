class Anniversary < ApplicationRecord
    validates :title, presence: true
    validates :anniversary_date, presence: true

end
