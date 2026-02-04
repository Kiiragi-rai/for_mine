module LineNotification
  class NotificationMessageBuilder

    def initialize(start_on:, last_sent_on:, schedule_for:,title:)
      @start_on = start_on
      @last_sent_on = last_sent_on
      @schedule_for = schedule_for
      @title = title
    end

    def build_message
      #通知日が対象記念日と同じなら
      if @schedule_for == @last_sent_on
        "今日が#{@title}記念日です"
        #通知日は通知開始日より後で、対象記念日より前
       elsif @start_on < @schedule_for && @schedule_for < @last_sent_on
        "#{@title}記念日まであと#{days_difference_calculator}日"
        # 通知日は通知開始日と同じなら
       elsif @schedule_for == @start_on
        "#{@title}記念日まであと#{days_difference_calculator}日\nプレゼントは決まったかな？？"
      end 
    end

  private 
  def days_difference_calculator
    (@last_sent_on - @schedule_for).to_i
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