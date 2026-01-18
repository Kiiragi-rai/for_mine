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

    Rails.logger.info "#{partner}"
    prompt = <<-PROMPT

    男性向けのプレゼントを２つ提案してください。あとその理由も。
  

 
    {
      "presentSuggestion": [
        { "name": "プレゼント提案1", "reason": "プレゼント提案１の理由"},
        { "name": "プレゼント提案2", "reason": "プレゼント提案2の理由"}
       ]
    }
    PROMPT

   

    @contents = GiftSuggestions::Generate.new(prompt).call

    render :new, status: :ok
  end
end
