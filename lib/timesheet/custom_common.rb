class CustomCommon
  class << self
    def calculated_month_year month, year
      if month == 1
        month = 12
        year -= 1
      else
        month -= 1
      end
      [month, year]
    end

    def format_unix_time_to_date num
      Time.at(num).utc.strftime Settings.format_date_to_timeline
    rescue StandardError
      ""
    end
  end
end
