require "roo"
class TimeSheet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  scope :order_date_desc, ->{order created_at: :desc}
  scope :search_staff_name, ->staff_name do
    where "staff_name LIKE ?", "%#{staff_name}%"
  end
  scope :search_employee_code, ->employee_code do
    where "employee_code LIKE ?", "#{employee_code}%"
  end
  scope :load_by_date, ->(date){where date: date}

  class << self
    def import file
      spreadsheet = open_spreadsheet file
      return false unless spreadsheet
      text_title = spreadsheet.row Settings.row_title
      month_year_of_timesheet = text_title[0].to_date
      header = spreadsheet.row Settings.row_header
      read_each_line spreadsheet, header, month_year_of_timesheet.month, month_year_of_timesheet.year
    end

    private
    def add_timesheet spreadsheet, row, header, month, year
      num_col_inprocess =
        spreadsheet.last_column - Settings.num_col_not_process
      (Settings.col_date_first...num_col_inprocess).step(2) do |j|
        time_in = CustomCommon.format_unix_time_to_date(row[j])
        time_out = CustomCommon.format_unix_time_to_date(row[j + 1])
        date = build_date(header[j].to_i, month, year)
        employee_code = row[Settings.col_employee_code]
        add_data_to_timesheet time_in, time_out, date, employee_code
      end
    end

    def read_each_line spreadsheet, header, month, year
      (Settings.data_row_first..spreadsheet.last_row).step(2) do |i|
        row = spreadsheet.row i
        user = User.find_by employee_code: row[Settings.col_employee_code]
        next if user.nil?
        add_timesheet spreadsheet, row, header, month, year
      end
    end

    def build_date hdate, month, year
      if hdate > Settings.end_day_pay && hdate <= Settings.end_of_month
        month, year = CustomCommon.calculated_month_year(month, year)
      end
      Date.parse("#{hdate}#{I18n.t 'slash'}#{month}#{I18n.t 'slash'}#{year}")
    end

    def add_data_to_timesheet time_in, time_out, date, employee_code
      timesheet = TimeSheet.load_by_date(date)
        .find_by employee_code: employee_code

      if timesheet.present?
        timesheet.reset_time_in time_in
        timesheet.reset_time_out time_out
      else
        TimeSheet.create date: date, time_in: time_in,
          time_out: time_out, employee_code: employee_code
      end
    end
  end

  def reset_time_in time_in_other
    return if time_in.blank? || time_in_other.blank? || time_in_other > time_in
    update_attributes time_in: time_in_other
  end

  def reset_time_out time_out_other
    return if time_out.blank? || time_out_other.blank? || time_out_other < time_out
    update_attributes time_out: time_out_other
  end
end
