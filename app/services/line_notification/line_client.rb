module LineNotification
  class LineClient
      DEFAULT_TEXT = "今日が記念日だぜ"

      # def send_message(_uid, message_contents: DEFAULT_TEXT)
      def self.send_message(uid:, text_messages: DEFAULT_TEXT)
        push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
      to: uid,
      messages: [
        Line::Bot::V2::MessagingApi::TextMessage.new(text: text_messages)
      ]
    )
      # メッセージ送信
      _response, status, _headers = client.push_message_with_http_info(
        push_message_request: push_request
      )
      status == 200

      Rails.logger.info "[LINENOTICATION:LINECLIENT] status=#{status}"
      end

      private

      def self.client
        @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
          channel_access_token: ENV.fetch("LINE_MESSAGING_CHANNEL_ACCESS_TOKEN")
        )
      end
  end
end
