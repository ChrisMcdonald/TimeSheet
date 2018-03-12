# frozen_string_literal: true

module TimeSheetsHelper
  def my_calendar(options = {}, &block)
    raise 'month_calendar requires a block' unless block_given?
    MyCalendar.new(self, options).render(&block)
  end
end
