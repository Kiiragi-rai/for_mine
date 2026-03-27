# == Schema Information
#
# Table name: gift_suggestions
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  error_message :text
#  input_json    :jsonb
#  result_json   :jsonb
#  status        :integer          default("pending"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_gift_suggestions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class GiftSuggestion < ApplicationRecord
  # いらないかな

  include Hashid::Rails
  belongs_to :user

  validate :monthly_limit, on: :create

  enum status: {
    pending: 0,
    success: 1,
    failure: 2,
    deleted: 3
  }

  def self.monthly_success_count(user)
    where(user: user).where(status: [:success, :deleted, :pending]).where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).count
  end
  # def monthly_success_count

  #   gift_suggestions.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).count
  # end
  # # for fileter method , 今月最初から今月末までcreated_atの数が５より多ければ、提案できないように、あとstatusでsuccess, created_atはnum > 5を満たす
  def monthly_limit
    count = user.gift_suggestions.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).count
    # where(status: :success).where(created_at: Time.current.beginning_of_month..Time.current.end_of_day).count

    if count >= 5
      errors.add(:base, "今月の上限に達しています")
    end

  end

  def self.ransackable_attributes(auth_object = nil)
    [ "status", "id" ]
  end
end
