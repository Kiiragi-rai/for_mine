class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!


  def new
    @contens = nil
  end

  def create
    @partner_info = current_user.partner
    Rails.logger.info "#{@partner_info}"
    prompt = <<-PROMPT
    「#{@partner_info}」を元におすすめプレゼントとそれを提案した理由をして下さい。
    以下のJSON形式で、キーや値の型も完全に守って応答してください。


    {
    "presentSuggestion": [
    { "suggestion1": "プレゼント提案1", "suggention1Reason": "プレゼント提案１の理由"},
    { "suggestion2": "プレゼント提案2", "suggention2Reason": "プレゼント提案2の理由"}
    ]
    }
    PROMPT

    @contents = GiftSuggestions::Generate.new(@prompt).call

    render :new, status: :ok
  end
end

