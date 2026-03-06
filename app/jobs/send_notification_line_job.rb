class SendNotificationLineJob < ApplicationJob
 queue_as :default

  # target_hashを渡す
  # messageのservice
  # 送信service
  def perform(management_id:)
  Rails.logger.info "ここからsend notificaitonline jobだよん"    # Do something later
    notification_management = NotificationManagement.find(management_id)

    notification_setting = notification_management.notification_setting
    user = User.find_by(id: notification_setting.anniversary.user_id)
    if Rails.env.development?
        uid = ENV["UID"]
    else
     uid = user.uid
    end



      return if uid.blank?

      message = LineNotification::NotificationMessageBuilder.new(
       start_on: notification_setting.start_on,
       end_on:  notification_setting.end_on,
       scheduled_for:  notification_management.scheduled_for,
       title:  notification_management.schedule_title)

      message_content = message.build_message
      Rails.logger.info "#{message_content} これメッセージ"


      # LineNotification::LineClient.send_line_message_with_button_to_home(uid: user.uid, text_messages: message_content)
      success = LineNotification::LineClient.send_line_message_with_button_to_home(uid: uid, messages: message_content)

      if success
        notification_management.update!(status: :success, sent_at: Time.current)
      else
        notification_management.update!(status: :failure)
      end

    rescue StandardError => e
      notification_management.update!(status: :failure, error_message: e.message) if notification_management
      Rails.logger.error("LINE SEND ERROR #{e.full_message}")
    end
end
