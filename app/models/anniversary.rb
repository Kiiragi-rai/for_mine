class Anniversary < ApplicationRecord
    validates :title, presence: true
    validate :body, presence: true

    belongs_to :user
end
