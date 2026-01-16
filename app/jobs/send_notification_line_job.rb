class SendNotificationLineJob < ApplicationJob
 queue_as :default

 DEFAULT_TEXT = "今日が記念日!"

  def perform(text_messages: DEFAULT_TEXT)
    # Do something later
    target_today = Date.today
    anniversaries = Anniversary.notification_target_get(target_today)
    Rails.logger.info "@annversariesの中身 #{anniversaries}"

    return if anniversaries.blank?

    anniversaries.each do |anniversary|
      uid = anniversary.user.uid

      next if uid.blank?

      LineNotification::LineClient.send_message(uid: uid, text_messages: DEFAULT_TEXT)
    end
  end
end
