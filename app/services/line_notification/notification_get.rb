module LineNotification
  class NotificationGet
    def setting
        sql= <<~SQL
      SELECT 
        u.id AS user_id,
        ns.id,
        ns.notification_time,
        ns.start_on,
        ns.end_on,
        a.title,
        date_trunc('hour', now() + interval '1 hour' )AS scheduled_for
        FROM anniversaries a
        INNER JOIN users u 
        ON a.user_id = u.id
        INNER JOIN notification_settings ns 
        ON a.id = ns.anniversary_id
        LEFT JOIN Notification_managements nm 
        ON ns.id = nm.notification_setting_id
        AND nm.scheduled_for = date_trunc('hour',now() + interval '1 hour')
        WHERE 
          ns.is_enabled = true
          AND
          nm.id IS NULL 
          AND
          CURRENT_DATE  BETWEEN ns.start_on and ns.end_on
          AND
          ns.notification_time = date_trunc('hour', CURRENT_TIME + interval '1 hour')
          AND 
          (ns.last_sent_on IS NULL 
          OR 
          ns.frequency_days <= ( CURRENT_DATE - ns.last_sent_on )
          )
          ORDER BY ns.id, u.id
        
      SQL


      result = ActiveRecord::Base.connection.exec_query(
        sql,
        "notification_date"
      )


      # result.map do |row|
      #   NotificationScheduleTartget.new(**row.to_h)
      # end

    end
  end
end

  # transaction入れる

  

      # EXTRACT(HOUR FROM ns.notification_time) = EXTRACT(HOUR FROM CURRENT_TIME + INTERVAL '1 hour')


      # SELECT 
      #   u.id AS user_id,
      #   ns.id,
      #   ns.notification_time,
      #   ns.start_on,
      #   ns.end_on
      #   ここで加工しないと渡してエラーの流れになるここで止める必要あり（通知時間を計算閏年は心配なし、日跨ぎと年跨ぎ不安検討）


  