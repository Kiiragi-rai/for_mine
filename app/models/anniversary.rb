class Anniversary < ApplicationRecord
    validates :title, presence: true
    validates :anniversary_date, presence: true

    belongs_to :user
end
