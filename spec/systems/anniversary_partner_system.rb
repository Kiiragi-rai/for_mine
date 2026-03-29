require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }

  describe 'ログイン前' do
    context "記念日ページへ遷移" do
      it "記念日ページアクセス失敗" do
        visit anniversaries_path
        expect(page). to have_content("You need to sign in or sign up before continuing.")
        expect(current_path).to eq root_path
      end
    end
    context "パートナーページへ遷移" do
      it "パートナーページアクセス失敗" do
        visit partner_path
        expect(page). to have_content("You need to sign in or sign up before continuing.")
        expect(current_path).to eq root_path
      end
    end
    context "プレゼント提案ページへ遷移" do
      it "プレゼント提案ページアクセス失敗" do
        visit new_gift_suggestion_path
        expect(page). to have_content("You need to sign in or sign up before continuing.")
        expect(current_path).to eq root_path
      end
    end
    context "プレゼント履歴ページへ遷移" do
      it "プレゼント履歴ページアクセス失敗" do
        visit gift_suggestions_path
        expect(page). to have_content("You need to sign in or sign up before continuing.")
        expect(current_path).to eq root_path
      end
    end
  end
  describe 'ログイン後' do
    before do
      sign_in user
      visit root_path
      # click_on 'ログイン'
      expect(page).to have_link 'anniversary'
      # driven_by(:rack_test)
      # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    end
    describe '記念日登録' do
    context '記念日情報を入力' do
      it '登録できる' do
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
    describe 'パートナー登録' do
   context 'パートナー情報入力' do
      it '登録できる' do
        # visit root_path
        click_link 'partner'
        click_on '見つけた'

        fill_in 'partner_name', with: 'test_name'

        click_button '登録'
        # 今表示されているWebページ
        expect(page).to have_content 'test_name'
      end
    end
    end
  end
end
