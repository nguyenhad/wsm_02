class CustomCommon
  class << self
    def format_unix_to_time num
      Time.at(num).utc.strftime(Settings.hour_minutes).in_time_zone
    rescue StandardError
      ""
    end

    def format_string_to_time string
      string.in_time_zone
    rescue TypeError
      ""
    end

    def format_string_to_date string, format_setting
      Date.strptime string, format_setting
    rescue TypeError
      ""
    end

    def convert_in_time_zone time
      time.strftime(Settings.hour_minutes).in_time_zone
    end
  end
end
