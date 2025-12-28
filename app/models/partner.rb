class Partner < ApplicationRecord

    belongs_to :user

    #一人につき一つ
    validates :user_id, uniqueness: true

    validates :name, presence: true
    validates :budget_max, numericality: { greater_than_or_equal_to: 0}, allow_nil: true
    validates :budget_min ,numericality: { greater_than_or_equal_to: 0}, allow_nil: true

    validate :budget_max_is_greater_than_budget_min

    # 予算（下限）が予算（上限）を超えないように
    def budget_max_is_greater_than_budget_min
        return if budget_min.blank? || budget_max.blank?
        if budget_min >= budget_max
            errors.add(:budget_min,"予算（下限）が予算（上限）を超えることはできません")
        end
    end
end 

