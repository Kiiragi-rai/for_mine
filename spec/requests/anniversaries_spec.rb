require 'rails_helper'

RSpec.describe "AnniversariesNotificationSettingsForm", type: :request do
  let(:user) { create(:user)}

  before do 
    sign_in user
  end

  describe "記念日登録のみ" do
    it "正常に" do
      expect {
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            frequency_days: "1"
          }
        }
      }.to change(Anniversary, :count).by(1)
    end
  end
  describe "記念日と通知設定登録" do
    it "正常" do
      expect {
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            is_enabled: true,
            frequency_days: "1",
            #  未来の時間にする
            start_on: Date.tomorrow.to_s,
            notification_hour: (Time.current.hour + 2) % 24
          }
        }
      }.to change(Anniversary, :count).by(1)
    end
  end
end
# == Schema Information
#
# Table name: notification_settings
#
#  id                :bigint           not null, primary key
#  end_on            :date
#  frequency_days    :integer          default("everyday"), not null
#  is_enabled        :boolean          default(FALSE), not null
#  last_sent_on      :date
#  notification_hour :integer
#  start_on          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  anniversary_id    :bigint           not null
#
# Indexes