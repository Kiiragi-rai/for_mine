class SendNotificationLineJob < ApplicationJob
 queue_as :default
 sidekiq_options retry: false

  # target_hashを渡す
  # messageのservice
  # 送信service
  def perform(management_id:)
  Rails.logger.info "ここからsend notificaitonline jobだよん"    # Do something later
    notification_management = NotificationManagement.find(management_id)

    notification_setting = notification_management.notification_setting
    user = User.find_by(id: notification_setting.anniversary.user_id)
    # uid = user.uid
    uid = ENV["UID"]

      return if uid.blank?

      message = LineNotification::NotificationMessageBuilder.new(start_on: notification_setting.start_on,
       end_on:  notification_setting.end_on, scheduled_for:  notification_management.scheduled_for, title:  notification_management.schedule_title)
      message_content = message.build_message
      Rails.logger.info "#{message_content} これメッセージ"
      # LineNotification::LineClient.send_line_message_with_button_to_home(uid: user.uid, text_messages: message_content)
      LineNotification::LineClient.send_line_message_with_button_to_home(uid: uid, messages: message_content)
      end
end
