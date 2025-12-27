class Partner < ApplicationRecord
    belongs_to :user

    validates :user_id, uniquness: true
end
