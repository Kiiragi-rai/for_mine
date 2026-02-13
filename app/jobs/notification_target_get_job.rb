class NotificationTargetGetJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false
# target取得
# management保存
# waituntilでjobに渡す
  def perform
    # Do something later
    notification_targets = LineNotification::NotificationGet.setting
    # Rails.logger.info "#{notification_targets} これなかみ"

    # ここはNotification_Managementのmodelでこの処理を書いていいのでは？
    notification_targets.each do |target|
      managed = NotificationManagement.create_for(target)
      Rails.logger.info " これがターゲットの中身だよん いまからLINEに渡すy#{managed.scheduled_for.in_time_zone}"
      management_id = managed.id 

      if Rails.env.development?
      # SendNotificationLineJob.perform_now(management_id: management_id)  
      p "missionコンプリート"
      else
      SendNotificationLineJob.set(wait_until: managed.scheduled_for).perform_later(management_id:management_id)
      end
    end
  end
end
