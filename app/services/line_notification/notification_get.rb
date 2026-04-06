module LineNotification
  class NotificationGet
    def self.setting
        # transaction必要ないかも、user_id, start_on, end_on , いらない

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

        #{'  '}

          WHERE
            ns.is_enabled = true

            AND
            nm.id IS NULL

            AND
            (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date between ns.start_on and ns.end_on

            AND
            ns.notification_hour = EXTRACT(HOUR FROM (b.next_hour AT TIME ZONE 'Asia/Tokyo'))

            AND
            (ns.last_sent_on IS NULL
            OR
            ns.frequency_days <= (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date - ns.last_sent_on
            OR#{' '}
            (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date = ns.end_on)
        #{'    '}
            ORDER BY ns.id, u.id

      SQL
      # -- (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date  BETWEEN ns.start_on and ns.end_on
      # -- EXTRACT(HOUR FROM ns.notification_time) =EXTRACT(HOUR FROM (b.next_hour AT TIME ZONE 'Asia/Tokyo'))

      results = ActiveRecord::Base.connection.exec_query(
        sql,
        "notification_date"
      )
      Rails.logger.info "#{results} これresultsだよおーーん"
      # rails に寄せる
      results.map do |row|
        AnniversaryNotificationTarget.new(row.to_h)
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
# def test_end_on_match
#   sql = <<~SQL
#     WITH base AS (
#       SELECT date_trunc('hour', now() + interval '1 hour') AS next_hour
#     )
#     SELECT
#       ns.id,
#       (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date AS target_date,
#       ns.end_on
#     FROM notification_settings ns
#     CROSS JOIN base b
#     WHERE
#       (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date = ns.end_on;
#   SQL

#   ActiveRecord::Base.connection.exec_query(sql).to_a
# end



# def testsetting
#   # transaction必要ないかも、user_id, start_on, end_on , いらない

#     sql= <<~SQL

#       WITH base AS (
#         SELECT
#           date_trunc(
#             'hour',
#             now() + interval '2 hour'
#           )AS next_hour
#       )
#     SELECT
#       u.id AS user_id,
#       ns.id AS notification_setting_id,
#       a.title,
#       b.next_hour AS scheduled_for

#       FROM anniversaries a
#       INNER JOIN users u
#       ON a.user_id = u.id

#       INNER JOIN notification_settings ns
#       ON a.id = ns.anniversary_id

#       CROSS JOIN base b

#       LEFT JOIN notification_managements nm
#       ON ns.id = nm.notification_setting_id
#       AND nm.scheduled_for = b.next_hour

#     #{'  '}

#       WHERE
#         ns.is_enabled = true

#         AND
#         nm.id IS NULL

#         AND
#         (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date between ns.start_on and ns.end_on

#         AND
#         ns.notification_hour = EXTRACT(HOUR FROM (b.next_hour AT TIME ZONE 'Asia/Tokyo'))

#         AND
#         (ns.last_sent_on IS NULL
#         OR
#         ns.frequency_days <= (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date - ns.last_sent_on
#         OR#{' '}
#         (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date = ns.end_on)
#     #{'    '}
#         ORDER BY ns.id, u.id

#   SQL
#   # -- (b.next_hour AT TIME ZONE 'Asia/Tokyo')::date  BETWEEN ns.start_on and ns.end_on
#   # -- EXTRACT(HOUR FROM ns.notification_time) =EXTRACT(HOUR FROM (b.next_hour AT TIME ZONE 'Asia/Tokyo'))

#   results = ActiveRecord::Base.connection.exec_query(
#     sql,
#     "notification_date"
#   )
#   Rails.logger.info "#{results.to_a} これresultsだよおーーん"

#   # results.map do |row|
#   #   AnniversaryNotificationTarget.new(row.to_h)
#   # end
#   end
