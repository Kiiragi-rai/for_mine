class NotificationTargetGetJob < ApplicationJob
  queue_as :default
  # target取得
  # management保存
  # waituntilでjobに渡す
  def perform
    # Do something later
    # 通知対象を取得
    notification_targets = LineNotification::NotificationGet.setting
    # Rails.logger.info "#{notification_targets} これなかみ"

    # ここはNotification_Managementのmodelでこの処理を書いていいのでは？
    # notification_managementへ登録
    notification_targets.each do |target|
      managed = NotificationManagement.create_for(target)

      # nil がsmanaged に入ることもあるため、スキップいるよな
      next unless managed
      Rails.logger.info " これがターゲットの中身だよん いまからLINEに渡すy#{managed.scheduled_for.in_time_zone}"

      # メッセージとグループ化やるならここ　マネジメントの前かな、登録できなくて一つにはなるけど　メッセージ作成ー＞グループ化が理想　ー＞　nm登録


      management_id = managed.id

      # 通知＆メッセージ作成JOBへ
      if Rails.env.development?
      SendNotificationLineJob.perform_now(management_id: management_id)
      p "missionコンプリート"
      else
      SendNotificationLineJob.set(wait_until: managed.scheduled_for).perform_later(management_id: management_id)
      end
    end
  end
end
