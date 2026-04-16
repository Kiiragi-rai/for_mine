require 'rails_helper'

RSpec.describe "AnniversariesNotificationSettingsForm", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "記念日登録のみ" do
    context "title, anniversary_dateを入力する" do
       it "記念日登録できる" do
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

   context "titleを入力しない" do
    it "登録できない" do
      expect {
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: nil,
            anniversary_date: "2025-01-01",
            frequency_days: "1"
          }
        }
      }.not_to change(Anniversary, :count)
    end
  end
  context "anniversary_dateを入力しない" do
    it "登録できない" do
      expect {
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "てスト",
            anniversary_date: nil,
            frequency_days: "1"
          }
        }
      }.not_to change(Anniversary, :count)
    end
   end
  context "anniversary_dateを未来の時間で登録" do
    it "登録できない" do
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "てスト",
            anniversary_date: Date.tomorrow,
            frequency_days: "1"
          }
        }
        expect(Anniversary.count).to eq 0
        expect(response.body).to include("記念日は未来には設定できません")
    end
   end
  end

  describe "記念日と通知設定登録" do
   context "記念日と通知設定を入力" do
    it "登録できる" do
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
   context "is_enabledをfalse, start_onを入力" do
    it "登録できない" do
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            is_enabled: false,
            frequency_days: "1",
            #  過去の時間にする
            start_on: Date.tomorrow.to_s,
            notification_hour: (Time.current.hour + 2) % 24
          }
        }
        expect(Anniversary.count).to eq 0
        expect(response.body).to include("知OFFのときは通知開始日は設定できません")
    end
   end
   context "is_enableをtrue, start_onを入力しない" do
    it "登録できない" do
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            is_enabled: true,
            frequency_days: "1",
            start_on: nil,
            notification_hour: (Time.current.hour + 2) % 24
          }
        }
        expect(Anniversary.count).to eq 0
        expect(response.body).to include("通知ONの時は通知開始日が必要です")
    end
   end
   context "start_onを現在の時刻から一時間後を入力" do
    it "登録できない" do
      time = 1.hours.from_now
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            is_enabled: true,
            frequency_days: "1",
            start_on: time.to_date,
            notification_hour: time.hour
          }
        }
        expect(Anniversary.count).to eq 0
        expect(response.body).to include("通知開始は現在時刻から1時間以上先にしてください")
    end
   end
   context "start_onを半年後以降の日付を入力" do
    it "登録できない" do
        post anniversaries_path, params: {
          anniversary_notification_setting_form: {
            title: "記念日",
            anniversary_date: "2025-01-01",
            is_enabled: true,
            frequency_days: "1",
            start_on: Date.current + 1.year,
            notification_hour: (Time.current.hour - 2) % 24
          }
        }
        expect(Anniversary.count).to eq 0
        expect(response.body).to include("通知開始日は半年以内に設定してください")
    end
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
