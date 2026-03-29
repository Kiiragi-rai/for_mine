require 'rails_helper'

RSpec.describe "Partnes", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "パートナー登録" do
    context "名前入力"
    it "登録できる" do
      expect {
        post partner_path, params: {
          partner: {
            name: "test_partner"
          }
        }
      }.to change(Partner, :count).by(1)
    end
  end
    context "名前未入力" do
    it "登録できない" do
      expect {
        post partner_path, params: {
          partner: {
            name: nil
          }
        }
      }.not_to change(Partner, :count)
    end
  end
end
