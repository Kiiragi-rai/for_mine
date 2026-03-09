require 'faraday'
require 'faraday/retry'



module GiftSuggestions
  class Generate

    RETRY_OPTIONS = {
  max: 2,
  interval: 0.05,
  interval_randomness: 0.5,
  backoff_factor: 2,
  retry_statuses: [429, 500, 502, 503, 504]
}


    def initialize(prompt)
      @prompt = prompt
      Rails.logger.info "promptの中身だよん#{@prompt}"
    end

    def call
      client = OpenAI::Client.new do |f|
        f.request :retry, RETRY_OPTIONS
      end

      begin
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [ { role: "user", content: @prompt } ],

          response_format: { type: "json_object" },

          temperature: 0.7
        }
      )
      # Rails.logger.info("response.class=#{response.class}")
      # Rails.logger.info("response.inspect=#{response.inspect}")

      raw_response = response.dig("choices", 0, "message", "content")
      # Rails.logger.info " raw_responseの中身だよ#{raw_response}"
      JSON.parse(raw_response || "{}")

      rescue StandardError => e
        Rails.logger.error(" プレゼント提案 #{e.full_message}")
        { error: e.message }
      end
    end
  end
end
