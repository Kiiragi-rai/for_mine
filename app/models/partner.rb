# == Schema Information
#
# Table name: partners
#
#  id         :bigint           not null, primary key
#  age        :integer
#  avoidances :text             default([]), is an Array
#  budget_max :integer
#  budget_min :integer
#  favorites  :text             default([]), is an Array
#  hobbies    :text             default([]), is an Array
#  job        :string
#  name       :string
#  relation   :string
#  sex        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_partners_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Partner < ApplicationRecord

    belongs_to :user

    #一人につき一つ
    validates :user_id, uniqueness: true

    validates :name, presence: { message: "を入力してね" },length: { maximum: 30 }
    validates :sex, allow_nil: true, length: { maximum: 30}
    validates :job, allow_nil: true, length: { maximum: 100}
    validates :budget_max, numericality: { greater_than_or_equal_to: 0}, allow_nil: true
    validates :budget_min ,numericality: { greater_than_or_equal_to: 0}, allow_nil: true
    validates :age, numericality: { greater_than: 0, less_than: 150 }, allow_nil: true
    validate :budget_max_is_greater_than_budget_min

# 配列用セッター
    def favorites=(value)
        super(normalize_list(value))
      end
    
      def avoidances=(value)
        super(normalize_list(value))
      end
    
      def hobbies=(value)
        super(normalize_list(value))
      end
  
    private
    # 予算（下限）が予算（上限）を超えないように
    def budget_max_is_greater_than_budget_min
        return if budget_min.blank? || budget_max.blank?
        if budget_min >= budget_max
            errors.add(:budget_min,"予算（下限）が予算（上限）を超えることはできません")
        end
    end
    
      
#  データ加工処理（配列）
      def normalize_list(value)
        return [] if value.blank?
    
        value.to_s
             .split(/[、,，\n]+/)
             .map(&:strip)
             .reject(&:blank?)
      end
end 

