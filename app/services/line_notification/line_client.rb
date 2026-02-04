module LineNotification
  class LineClient
      DEFAULT_TEXT = "今日が記念日だぜ"

      def self.send_line_message_with_button_to_home(uid:,message:)
        # uid:じゃなくて、実際はuser_id, schedule_forはtdate ここでtimeとdate = time stamp 作成
        # JOBではtime使うけどここじゃいらない　,notiication_time:　
        button_template = Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
          text: message,
          actions: [
            Line::Bot::V2::MessagingApi::URIAction.new(
              label: "for_mineへ",
              uri: ENV["APP_BASE_URL"]
            )
          ]
        )
        template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
          alt_text: message,
          template: button_template
        )

        push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
          to: uid,
          messages: [ template_message ]
        )

      _response, status, _headers = client.push_message_with_http_info(
        push_message_request: push_request
      )
        status == 200
    end

      private
      def self.client
        @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
          channel_access_token: ENV.fetch("LINE_MESSAGING_CHANNEL_ACCESS_TOKEN")
        )
      end
  end
end

    #   def self.send_message(uid:, text_messages: DEFAULT_TEXT)
    #     push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
    #   to: uid,
    #   messages: [
    #     Line::Bot::V2::MessagingApi::TextMessage.new(text: text_messages)
    #   ]
    # )
    #   # メッセージ送信
    #   _response, status, _headers = client.push_message_with_http_info(
    #     push_message_request: push_request
    #   )
    #   status == 200

    #   Rails.logger.info "[LINENOTICATION:LINECLIENT] status=#{status}"
    #   end
