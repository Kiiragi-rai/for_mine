require 'rails_helper'

RSpec.describe "Partners", type: :request do
  let(:user) { create(:user) }
  let!(:partner) { create(:partner, user: user) }

  before do
    sign_in user
    allow(GiftSuggestions::PromptBuilder).to receive(:new).and_return(double(call: "dummy"))
  end


  describe "POST /gift_suggestions" do
    it "提案できる" do
      expect {
        post gift_suggestions_path
      }.to change(GiftSuggestion, :count).by(1)
    end
  end
end
