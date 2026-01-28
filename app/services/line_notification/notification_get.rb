module LineNotification
  class NotificationGet
  # transaction入れる
    def setting
      sql= <<~SQL
      SELECT 
        u.id AS user_id,
        u.uid,
        ns.id,
        ns.notification_time,
        ns.start_on,
        ns.end_on
        FROM anniversaries a
        INNER JOIN users u 
        ON a.user_id = u.id
        INNER JOIN notification_settings ns 
        ON a.id = ns.anniversary_id
        WHERE 
          ns.is_enabled = true
          AND
          CURRENT_DATE  BETWEEN ns.start_on and ns.end_on
          AND
          EXTRACT(HOUR FROM ns.notification_time) = EXTRACT(HOUR FROM CURRENT_TIME + INTERVAL '1 hour')
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


      result.map do |row|
        NotificationScheduleTartget.new(**row.to_h)
      end




      #      sql= <<~SQL
    #   SELECT 
    #   u.id AS user_id,
    #   u.uid,
    #   ns.id 
    #   FROM anniversaries a

    #   ns.notificaiton_time,
    #   ns.notification_date,
    #   ns.start_on,
    #   ns.end_on

    #   今日の通知の組み立てはtarget側でやる


    #   INNER JOIN users u 
    #   ON a.user_id = u.id
    #   INNER JOIN notification_settings ns 
    #   ON a.id = ns.anniversary_id

    #   # leftjoin
    #   WHERE 
    #     ns.is_enabled = true
    
    #     AND
    #     CURRENT_DATE  BETWEEN ns.start_on and ns.end_on

      
    #     AND
    #     EXTRACT(HOUR FROM ns.notification_time) = EXTRACT(HOUR FROM CURRENT_TIME + INTERVAL '1 hour')

    #     AND 
    #     (ns.last_sent_on IS NULL 
    #     OR 
    #     ns.frequency_days <= ( CURRENT_DATE - ns.last_sent_on )
    #     )

    #     ORDER BY ns.id, u.id
      
    # SQL


      
# 閏年だけ書く


#       result = ActiveRecord::Base.connection.exec_query(
#         sql,
#         "notification_data",
#       )

#     end
#     end
#   end
# end          # AND 
#           # n.frequency_days = n.last_sent_on - cunnret_date



          # module LineNotification
          #   class NotificationGet
            
          #     def setting
          #       sql= <<~SQL
          #       SELECT 
          #         u.id AS user_id,
          #         u.uid,
          #         ns.id ,
          #         CASE
          #          WHEN ns.notification_time = (zero:zero:zero)
          #          make stamp なし　アプリで組み立て
          #         THEN make_timestamp(
          #           CAST(EXTRACT(YEAR FROM CURRENTDATE) +INTERVAL '1.' )
          #           current date + interval + 1 day 
          #         )
          
          #         make_timestamp(
          #           current_dateime
          #         )
          #         END as notification_schedule
          #         FROM anniversaries a
          
          #         ns.notificaiton_time ,
          #         ns.notification_date,
          
          
          #         INNER JOIN users u 
          #         ON a.user_id = u.id
          #         INNER JOIN notification_settings ns 
          #         ON a.id = ns.anniversary_id
          #         WHERE 
          #           ns.is_enabled = true
          #           AND 
          
          
          #           uruudosisyori 
          #           ns.start_on <= CURRENT_DATE
          #           AND
          #           make_date(
          #             CAST(EXTRACT(YEAR FROM CURRENT_DATE) AS int),
          #             CAST(EXTRACT(MONTH FROM a.anniversary_date) AS int),
          #             CAST(EXTRACT(DAY FROM a.anniversary_date) AS int)
          #           ) >= CURRENT_DATE
          
                  
          #           AND
          #           EXTRACT(HOUR FROM ns.notification_time) = EXTRACT(HOUR FROM CURRENT_TIME + INTERVAL '1 hour')
          
          #           AND 
          #           (ns.last_sent_on IS NULL 
          #           OR 
          #           ns.frequency_days <= ( CURRENT_DATE - ns.last_sent_on )
          #           )
          
          
                  
          #       SQL
          # # 閏年だけ書く
          
          
          #       result = ActiveRecord::Base.connection.exec_query(
          #         sql,
          #         "notification_data",
          #       )
          
          #     end
          #     end
          #   end
          # end          # AND 
          #           # n.frequency_days = n.last_sent_on - cunnret_date
          
          