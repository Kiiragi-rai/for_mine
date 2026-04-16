require 'rails_helper'

RSpec.describe "Anniversries", type: :model do
  let(:user) { create(:user) }

  describe "POST /anniversaries" do
    it "titleないと無効" do
      anniversary = Anniversary.new(title: nil, anniversary_date: Date.today)
      expect(anniversary).to be_invalid
    end

    it "anniversary_dateがないと無効" do
      anniversary = Anniversary.new(title: "記念日", anniversary_date: nil)
      expect(anniversary).to be_invalid
    end
  end
end
