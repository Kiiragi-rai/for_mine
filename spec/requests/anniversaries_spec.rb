require 'rails_helper'

RSpec.describe "Anniversaries", type: :request do
  let(:user) { create(:user)}

  before do 
    sign_in user
  end

  describe "POST /anniversaries" do
    it "作成できる" do
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
end