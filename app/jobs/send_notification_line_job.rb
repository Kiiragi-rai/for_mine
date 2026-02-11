class SendNotificationLineJob < ApplicationJob
 queue_as :default

 
# target_hashを渡す
#messageのservice
# 送信service
  def perform(target_hash)
    # Do something later
    notification_target = AnniversaryNotificationTarget.new(target_hash)

      user = User.find_by(id:notification_target.user_id)
      return if user.blank? || user.uid.blank?

      message = LineNotification::NotificationMessageBuilder.new(start_on: notification_target.start_on, end_on:  notification_target.end_on, schedule_for:  notification_target.schedule_for, title:  notification_target.title)
      message_content = message.build_message
      LineNotification::LineClient.send_line_message_with_button_to_home(uid: user.uid, text_messages: message_content)
    end
end
