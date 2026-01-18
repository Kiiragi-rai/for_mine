require "json"

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!


  def new
        @contents = session.delete(:gift_contents)
  end

  def create
    if Rails.env.production?
    partner = current_user.partner

     partner_info = {
      sex: partner.sex.presence || "未入力",
      age: partner.age.presence || "未入力",
      job: partner.job.presence || "未入力",
      relation: partner.relation.presence || "未入力",
      budget_min: partner.with_yen(partner.budget_min),
      budget_max: partner.with_yen(partner.budget_max),
      favorites: partner.turn_to_string(partner.favorites),
      avoidances: partner.turn_to_string(partner.avoidances),
      hobbies: partner.turn_to_string(partner.hobbies)
    }
 
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


    elsif Rails.env.development?
        @contents = {
      "presentSuggestion" => [
        { "name" => "文房具セット", "reason" => "..." },
        { "name" => "ポケットサイズのゲーム", "reason" => "..." },
        { "name" => "オリジナルのメッセージカード", "reason" => "..." }
      ]
    }
    end

    session[:gift_contents] = @contents
    redirect_to new_gift_suggestion_path, notice: "提案を生成しました"
  end
end
