require 'rails_helper'

RSpec.describe "Partners", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end


  describe "POST /partner" do
    it "正常に" do
      expect {
        post partner_path, params: {
          partner: {
            name: "test_partner"
          }
        }
      }.to change(Partner, :count).by(1)
    end
  end
end
