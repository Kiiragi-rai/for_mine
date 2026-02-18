class CalendarEvent
  attr_reader :date, :title

  def initialize(target_date:, title:)
    @target_date = date 
    @title = title 
  end

  def start_time
    date
  end
end