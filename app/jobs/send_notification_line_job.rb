class SendNotificationLineJob < ApplicationJob
 queue_as :default

 
# target_hashを渡す
#messageのservice
# 送信service
  def perform(target_hash)
    # Do something later
    target_today = Date.today
    anniversaries = Anniversary.notification_target_get(target_today)
    Rails.logger.info "@annversariesの中身 #{anniversaries}"

    return if anniversaries.blank?

    anniversaries.each do |anniversary|
      uid = anniversary.user.uid

      next if uid.blank?

      message = LineNotification::NotificationMessageBuilder.new(start_on: start_on, last_sent_on: last_sent_on, schedule_for: schedule_for, title: title)
      message_content = message.build_message
      LineNotification::LineClient.send_line_message_with_button_to_home(uid: uid, text_messages: message)
    end
  end
end
