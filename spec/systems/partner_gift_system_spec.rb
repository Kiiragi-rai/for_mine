require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  # let!(:partner) { create(:partner, user: user) }


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
      create(:partner, user: user)
      visit root_path
      # visit root_path
      # click_on 'ログイン'
      expect(page).to have_link 'anniversary'
      # driven_by(:rack_test)
      # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    end
  describe 'プレゼント提案' do
    context '提案ボタンをクリック' do
      it '提案できる' do
        puts user.partner.present?
        puts "==== current_path ===="
        puts current_path

        puts "==== page content ===="
        puts page.body

        expect(page).to have_link("プレゼント提案")

        click_link 'プレゼント提案'

        puts "==== after click ===="
        puts current_path

        expect(current_path).to eq new_gift_suggestion_path
      end
    end
    end

  describe 'プレゼント履歴' do
    context 'プレゼント提案履歴ページ遷移' do
      it '遷移成功' do
        puts user.partner.present?
        puts "==== current_path ===="
        puts current_path

        puts "==== page content ===="
        puts page.body

        expect(page).to have_link("プレゼント履歴")

        click_link "プレゼント履歴"


        puts "==== after click ===="
        puts current_path

        expect(current_path).to eq gift_suggestions_path
        expect(page).to have_content("1")
      end
    end
    end
  end
end
