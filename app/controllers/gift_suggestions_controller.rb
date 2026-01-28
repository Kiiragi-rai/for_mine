require "json"

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @results = current_user.gift_suggestions.where.not(result_json: nil).map do |gs|
    # @results = current_user.gift_suggestions.map do |gs|
      # [] 入れた方がいいらしい
      { id:gs.id,
       names: gs.result_json&.dig("presentSuggestions")&.map { |h| h["name"] }&.first(3) || []}
    end
  end

  def new
        @contents = session.delete(:gift_contents)
  end

  def create
        # if Rails.env.production?
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

        # ここでinfo を保存と渡す
        # prompt分岐

        # Rails.logger.info "#{target.input_json}"

        prompt = <<-PROMPT

        #{partner_info.to_json}を元におすすめのプレゼント3つとその理由を教えてください。
        以下のJSON形式で、キーや値の型も完全に守って応答してください。

        {
          "presentSuggestions": [
            { "name": "プレゼント提案1", "reason": "プレゼント提案１の理由"},
            { "name": "プレゼント提案2", "reason": "プレゼント提案2の理由"},
            { "name": "プレゼント提案3", "reason": "プレゼント提案3の理由"}
           ]
        }
        PROMPT

        last_result =  current_user.gift_suggestions&.last&.result_json  
        names = last_result&.dig("presentSuggestions")&.map { |h| h["name"] }

        if last_result.present?
        prompt << "\n #{names.to_json}は避けてください" 
        end

        # prompt << "\n 次のプレゼント名は避けてください: #{names}" if names.present?

        # @contents = GiftSuggestions::Generate.new(prompt).call

        # elsif Rails.env.development?  
        @contents = {
      "presentSuggestions" => [
        { "name" => "文房具セット", "reason" => "..." },
        { "name" => "ポケットサイズのゲーム", "reason" => "..." },
        { "name" => "オリジナルのメッセージカード", "reason" => "..." }
      ]
    }

    target = current_user.gift_suggestions.build(result_json: @contents)
    if target.save
   session[:gift_contents] = @contents
    redirect_to new_gift_suggestion_path, notice: "提案を生成しました"
    else
      render :new, status: :unprocessable_entity
    end
    # end
  end

  def destroy 
    gs = current_user.gift_suggestions.find(params[:id])
    gs.update!(result_json: nil) 
    # gs.destroy!
    redirect_to gift_suggestions_path
  end
end