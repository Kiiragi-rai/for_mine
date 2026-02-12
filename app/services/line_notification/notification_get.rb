module LineNotification
  class NotificationGet
    def self.setting
      ActiveRecord::Base.transaction do
        sql= <<~SQL

          WITH base AS (
            SELECT 
              date_trunc(
                'hour',
                now() + interval '1 hour' 
              )AS next_hour
          )
        SELECT 
          u.id AS user_id,
          ns.id AS notification_setting_id,
          ns.start_on,
          ns.end_on,
          a.title,
          b.next_hour AS scheduled_for

          FROM anniversaries a
          INNER JOIN users u 
          ON a.user_id = u.id

          INNER JOIN notification_settings ns 
          ON a.id = ns.anniversary_id

          CROSS JOIN base b

          LEFT JOIN notification_managements nm 
          ON ns.id = nm.notification_setting_id
          AND nm.scheduled_for = b.next_hour
  
          WHERE 
            ns.is_enabled = true
            AND
            nm.id IS NULL 
            AND
            ns.notification_time = b.next_hour::time
    
            AND 
            (ns.last_sent_on IS NULL 
            OR 
            ns.frequency_days <= (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date - ns.last_sent_on )
            
            ORDER BY ns.id, u.id

      SQL
                # -- (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date  BETWEEN ns.start_on and ns.end_on
                  # -- EXTRACT(HOUR FROM ns.notification_time) =EXTRACT(HOUR FROM (b.next_hour AT TIME ZONE 'Asia/Tokyo'))

      results = ActiveRecord::Base.connection.exec_query(
        sql,
        "notification_date"
      )
      Rails.logger.info "#{results} これresultsだよおーーん"

      results.map do |row|
        AnniversaryNotificationTarget.new(row.to_h)
      end
      end
    end
  end
end
          # EXTRACT(HOUR FROM ns.notification_time) =EXTRACT(HOUR FROM b.next_hour)
# ns.notification_time = date_trunc('hour', b.next_hour)::time
        # ActiveRecord::Base.connection.execute("SET LOCAL TIME ZONE 'Asia/Tokyo'")

  # transaction入れる

        # ns.notification_time = date_trunc('hour', (now() AT TIME ZONE 'Asia/Tokyo') + interval '1 hour')::time


      # EXTRACT(HOUR FROM ns.notification_time) = EXTRACT(HOUR FROM CURRENT_TIME + INTERVAL '1 hour')


      # SELECT 
      #   u.id AS user_id,
      #   ns.id,
      #   ns.notification_time,
      #   ns.start_on,
      #   ns.end_on
      #   ここで加工しないと渡してエラーの流れになるここで止める必要あり（通知時間を計算閏年は心配なし、日跨ぎと年跨ぎ不安検討）


          # date_trunc('hour', (now() AT TIME ZONE 'Asia/Tokyo') + interval '1 hour' )AS scheduled_for
