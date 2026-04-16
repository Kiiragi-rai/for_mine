require 'rails_helper'

RSpec.describe "Partners", type: :request do
  let(:user) { create(:user) }


  before do
    sign_in user
    allow(GiftSuggestions::PromptBuilder).to receive(:new).and_return(double(call: "dummy"))
  end


  describe "プレゼント提案（パートナー登録あり）" do
    let!(:partner) { create(:partner, user: user) }
    context "パートナー登録済み" do
    it "提案できる" do
      expect {
        post gift_suggestions_path
      }.to change(GiftSuggestion, :count).by(1)
    end
    end
  end

  describe "プレゼント提案（パートナー登録なし）" do
    context "パートナー未登録" do
    it "提案できない" do
      expect {
        post gift_suggestions_path
      }.not_to change(GiftSuggestion, :count)
    end
    end
  end
end
