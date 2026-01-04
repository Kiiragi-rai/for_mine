class SendNotificationEmailsJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    target_today = Date.today
    p target_today 
    @anniversaries = Anniversary.notification_target_get(target_today)
    p @anniversaries
    @anniversaries.each do |anniversary|
      email = anniversary.user.email
      your_anniversary_date = anniversary.anniversary_date
      
      p email
      p your_anniversary_date

      NotificationMailer.send_notification_mail(email,your_anniversary_date).deliver_now
    end
  end
end
