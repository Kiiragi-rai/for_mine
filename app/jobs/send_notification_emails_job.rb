class SendNotificationEmailsJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    target_today = Date.today
    Rails.logger.info "[SendNotificationEmailsJob] target_today=#{target_today}"

    @anniversaries = Anniversary.notification_target_get(target_today)
    Rails.logger.info "[SendNotificationEmailsJob] anniversaries_count=#{@anniversaries.size}"
    Rails.logger.info "[SendNotificationEmailsJob] anniversaries_ids=#{@anniversaries.pluck(:id).join(',')}"

    @anniversaries.each do |anniversary|
      email = anniversary.user.email
      your_anniversary_title = anniversary.title
      Rails.logger.info "[SendNotificationEmailsJob] sending to=#{email} anniversary_id=#{anniversary.id} anniversary_date=#{your_anniversary_title}"


      NotificationMailer.send_notification_mail(email,your_anniversary_title).deliver_now
      Rails.logger.info "[SendNotificationEmailsJob] sending to=#{email} anniversary_id=#{anniversary.id} anniversary_date=#{your_anniversary_title}"

    end
    Rails.logger.info "[SendNotificationEmailsJob] done"

  end
end
