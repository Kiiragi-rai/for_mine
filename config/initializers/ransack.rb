Ransack.configure do |config|
  config.add_predicate :during_month,
                        :arel_predicate => :between,
                        :formatter => proc { |v|
                          unless v.month == 12 # 12月度以外の処理
                            #月末日をenddayに代入 v.monthを+1して最後にdateを1引くことで月末日を取得している。
                            endday = Time.zone.parse("#{v.year}-#{v.month + 1}-1").to_date - 1
                          else # 12月度の処理
                            # 12月度の時はv.monthはインクリメントしない（エラー回避）
                            # v.yearを+1で翌年に、monthは1月固定、
                            # 最後に1日に固定したdateを1引くことで12月の末日をenddayに代入している。
                            endday = Time.zone.parse("#{v.year + 1}-1-1").to_date - 1
                          end
                          #検索月の初日から月末日まで
                          Time.zone.parse("#{v.year}-#{v.month}-1").to_date..endday
                        },
                        :type => :date
    end