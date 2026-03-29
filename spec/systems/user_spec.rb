require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン後' do
    before do
      visit root_path
      click_on 'ログイン'
      expect(page).to have_content 'anniversary'
      # driven_by(:rack_test)
      # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    end
    context '正しい情報を入力した場合' do
      it '記念日作成できる' do
        click_on 'anniversary'
        click_on '記念日作成'

        fill_in 'anniversary_notification_setting_form_title', with: 'サイコーの日'
        fill_in 'anniversary_notification_setting_form_anniversary_date', with: '2020-03-01'

        click_button '作成'
        # 今表示されているWebページ
        expect(page).to have_content 'サイコーの日'
      end
    end
  end
end
