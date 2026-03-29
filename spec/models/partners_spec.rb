require 'rails_helper'

RSpec.describe "Partners", type: :request do
  let(:user) { create(:user) }

  describe "POST /partners" do
    it "partnerのnameは30文字以上は登録できない" do
      partner = Partner.new(name: "1234567890123456789012345678901234567890")
      expect(partner).to be_invalid
    end
    it "partnerのnameカラムなしでは登録できない" do
      partner = Partner.new(name: nil)
      expect(partner).to be_invalid
    end

    it "partnerのsexカラムは30文字以上は登録できない" do
      partner = Partner.new(name: "test", sex: "1234890123456789012345678901234567890")
      expect(partner).to be_invalid
    end
    it "partnerのjobカラムは100文字以上は登録できない" do
      partner = Partner.new(name: "test", job: "会社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、
      不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、
      警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、
      不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、
      消防士、不動産、社員、警察官、消防士、不動産、社員、警察官、消防士、不動産、")
      expect(partner).to be_invalid
    end
    it "partnerのbudget_maxカラムは0円以上で登録できない" do
      partner = Partner.new(name: "test", budget_max: -1)
      expect(partner).to be_invalid
    end
    it "partnerのbudget_minカラムは0円以上で登録できない" do
      partner = Partner.new(name: "test", budget_max: -1)
      expect(partner).to be_invalid
    end
    it "partnerのbudget_minカラムはbudget_maxより多い金額は登録できない" do
      partner = Partner.new(name: "test", budget_max: 100, budget_min: 200)
      expect(partner).to be_invalid
    end
  end
end


# class Partner < ApplicationRecord
#   belongs_to :user

#   # 一人につき一つ
#   validates :user_id, uniqueness: true

#   validates :name, presence: { message: "を入力してね" }, length: { maximum: 30 }
#   validates :sex, allow_nil: true, length: { maximum: 30 }
#   validates :job, allow_nil: true, length: { maximum: 100 }
#   validates :budget_max, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
#   validates :budget_min, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
#   validates :age, numericality: { greater_than: 0, less_than: 150 }, allow_nil: true
#   validate :budget_max_is_greater_than_budget_min

#   # 配列用セッター
#   def favorites=(value)
#       super(normalize_list(value))
#     end

#     def avoidances=(value)
#       super(normalize_list(value))
#     end

#     def hobbies=(value)
#       super(normalize_list(value))
#     end



#     def turn_to_string(object)
#        object.join("、").presence || "未入力"
#     end

#     def with_yen(object)
#       return "未入力" if object.blank?

#       "#{object}円"
#     end

#     def change_to_progress_bar_value
#       attrs = attributes.except("id", "created_at", "updated_at", "user_id")
#       attrssize = attrs.size

#       attrs2 = attrs.delete_if { |k, v| v.blank? }
#       attrs2size = attrs2.size

#       ((attrs2size.to_f / attrssize) * 100).round
#     end

#     def progress_bar_color
#       value = change_to_progress_bar_value

#       return "text-bg-success" if value >= 80
#       return "text-bg-warning" if value >= 50
#       "text-bg-danger"
#     end


#   private
#   # 予算（下限）が予算（上限）を超えないように
#   def budget_max_is_greater_than_budget_min
#       return if budget_min.blank? || budget_max.blank?
#       if budget_min >= budget_max
#           errors.add(:budget_min, "予算（下限）が予算（上限）を超えることはできません")
#       end
#   end


#     #  データ加工処理（配列）
#     def normalize_list(value)
#       return [] if value.blank?

#       value.to_s
#            .split(/[、,，\n]+/)
#            .map(&:strip)
#            .reject(&:blank?)
#     end

# # def change_to_progress_bar_value
# #   attributes.delete_if { |k, v| v.blank? }
# # end
# end
