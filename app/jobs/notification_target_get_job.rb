class NotificationTargetGetJob < ApplicationJob
  queue_as :default
# target取得
# management保存
# waituntilでjobに渡す
  def perform
    # Do something later
    notification_targets = LineNotification::NotificationGet.setting
    # Rails.logger.info "#{notification_targets} これなかみ"

    # ここはNotification_Managementのmodelでこの処理を書いていいのでは？
    notification_targets.each do |target|
      NotificationManagement.create_for(target)
      # Rails.logger.info " これがターゲットの中身だよん#{target}"
      target_hash = target.attributes
      # SendNotificationJob.set(wait_until: target.scheduled_for).perform_later(target_hash)
    end
  end
end
