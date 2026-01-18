module GiftSuggestions
  class Generate
    
    def initializer(prompt)
      @prompt = prompt
    end

    def call 
      client = OpenAI::Client.new
      
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: @prompt}],

          response_format: { type: "json_object" },

          temperature: 0.7,
        }
      )

      raw_response = response.dig("choise", 0, "message", "content")
      @content = JSON.parse(raw_response)
    end
  end
end