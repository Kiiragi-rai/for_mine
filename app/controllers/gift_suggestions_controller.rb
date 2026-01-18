require 'json'

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!


  def new
    @contents = nil
  end
    「#{ partner_info }」を元におすすめプレゼントとそれを提案した理由をして下さい。
  #  関係性は#{partner.relation},年齢は#{partner.age},好きなものは#{partner.likes.join(",")}で、これを元に
  #   お薦めのプレゼントとその理由を教えてください
  #   以下のJSON形式で、キーや値の型も完全に守って応答してください。

  def create
    partner = current_user.partner

    partner_info = {
      sex: partner.sex.presence || "未入力",
      age: partner.age.presence || "未入力",
      job: partner.job.presence || "未入力",
      relation: partner.relation || "未入力",
      budget_min: partner.with_yen(partner.budget_min)
      budget_max: partner.with_yen(partner.budget_max)
      favorites: partner.turn_to_string(partner.favorites),
      avoidances: partner.turn_to_string(partner.avoidances),
      likes: partner.turn_to_string(partner.favorites)
  }

    Rails.logger.info "#{partner}"
    prompt = <<-PROMPT

    #{partner_info.to_json}を元におすすめのプレゼント3つとその理由を教えてください。
    以下のJSON形式で、キーや値の型も完全に守って応答してください。
  
    {
      "presentSuggestion": [
        { "name": "プレゼント提案1", "reason": "プレゼント提案１の理由"},
        { "name": "プレゼント提案2", "reason": "プレゼント提案2の理由"},
        { "name": "プレゼント提案3", "reason": "プレゼント提案3の理由"}
       ]
    }
    PROMPT

  
    @contents = GiftSuggestions::Generate.new(prompt).call

    render :new, status: :ok
  end
end

