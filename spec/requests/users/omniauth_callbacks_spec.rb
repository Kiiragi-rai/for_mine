require 'rails_helper'

RSpec.describe "LINEログイン", type: :request do
  before do 

    OmniAuth.config.test_mode = true


    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new({
      provider: "line",
      uid: "12345",
      info: {
        name: "testuser"
      }
    })
  end

  describe "GET /users/auth/line/callback" do
    it "ユーザーが作成されてログインする" do
      expect {
        get "/users/auth/line/callback"
    }.to change(User, :count).by(1)

    expect(response).to redirect_to(user_root_path)
    end
  end
end