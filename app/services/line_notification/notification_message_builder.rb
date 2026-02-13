module LineNotification
  class NotificationMessageBuilder
    def initialize(start_on:, scheduled_for:, title:, end_on:)
      @start_on = start_on
      @scheduled_for = scheduled_for
      @end_on = end_on
      @title = title
    end

    def build_message
      Rails.logger.info "これから messe-ge つくるよ"
      # 通知日が対象記念日と同じなら
      # schedule_forはdatetime型
      if scheduled_date == @end_on
        "今日が#{@title}記念日です"
      # 通知日は通知開始日より後で、対象記念日より前
      elsif @start_on < scheduled_date && scheduled_date < @end_on
        "#{@title}記念日まであと#{days_difference_calculator}日"
      # 通知日は通知開始日と同じなら
      elsif scheduled_date == @start_on
        "#{@title}記念日まであと#{days_difference_calculator}日\nプレゼントは決まったかな？？"
      end
    end

  private

  def scheduled_date
    @scheduled_for.to_date
  end


  def days_difference_calculator
    (@end_on - scheduled_date).to_i
  end
  end
end


# start_on date型、 last_sent_on date型、schedule_for通知する日　date型 ,title string型
# message service作成
# message分岐 ここでmessage =下の中分岐から獲得

# if schedule_for = last_sent_on
#   今日がtitle記念日です
#  elsif start_on < schedule_for && schedule_for < last_sent_on
#   title記念日まであとOO日
#  elsif schedule_for = start_on
#   title記念日まで後OO日
#   プレゼントは決まったかな？？
# end
