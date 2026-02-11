class NotificationTargetGetJob < ApplicationJob
  queue_as :default
# target取得
# management保存
# waituntilでjobに渡す
  def perform
    # Do something later
    notification_targets = LineNotification::NotificationGet.setting

    # ここはNotification_Managementのmodelでこの処理を書いていいのでは？
    notification_target.each do |target|
      notification_management = NotificaitonManagement.find_or_create_by(
        notificaiton_setting_id: target.notificaiton_setting_id,
        scheduled_for: target.scheduled_for
      ) do |management| 
        management.schedule_title = target.notification_title
      end
      management
    end


    target_hash = target.attributes


    SendNotificationJob.set(wait_until: target.scheduled_for).perform_later(target_hash)
    # 時間はLINEの方で調整してもいいのでは？
    SendNotificationJob.perform(target_hash)




  end
end
