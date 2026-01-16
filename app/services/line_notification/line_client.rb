module LineNotification
  class LineClient
    def send_message(uid, message_contents)
      push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
    to: uid,
    messages: [
      Line::Bot::V2::MessagingApi::TextMessage.new(text: message_contents)
    ]
  )

  # メッセージ送信
  _response, status, _headers = client.push_message_with_http_info(
    push_message_request: push_request
  )
  status == 200
  end
    

  

  private 

      def client
      @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
        channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
      )
    end
  end
end