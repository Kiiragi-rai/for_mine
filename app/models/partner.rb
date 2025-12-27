class Partner < ApplicationRecord
    belongs_to :user

    #一人につき一つ
    validates :user_id, uniqueness: true 
end
