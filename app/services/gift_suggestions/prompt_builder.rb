module GiftSuggestions
  class PromptBuilder
    def initialize(partner_info:, last_result:)
      @partner_info = partner_info
      @last_result = last_result
    end

    def call
      prompt = <<~PROMPT

      #{@partner_info.to_json}を元におすすめのプレゼント3つとその理由を教えてください。
      以下のJSON形式で、キーや値の型も完全に守って応答してください。

      {
        "presentSuggestions": [
          { "name": "プレゼント提案1", "reason": "プレゼント提案１の理由"},
          { "name": "プレゼント提案2", "reason": "プレゼント提案2の理由"},
          { "name": "プレゼント提案3", "reason": "プレゼント提案3の理由"}
         ]
      }
      PROMPT

      # 通知履歴
      names = @last_result&.dig("presentSuggestions")&.map { |h| h["name"] }

      if names.present?
      prompt << "\n #{names.to_json}は避けてください"
      end

      prompt
    end
  end
end
