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
    def add_timesheet spreadsheet, record_timesheet, header, month, year
      num_col_inprocess =
        spreadsheet.last_column - Settings.num_col_not_process
      (Settings.col_date_first...num_col_inprocess).step(2) do |j|
        time_in_timesheet = record_timesheet[j].blank? ? "" :
          CustomCommon.format_unix_time_to_date(record_timesheet[j])
        time_out_timesheet = record_timesheet[j + 1].blank? ? "" :
          CustomCommon.format_unix_time_to_date(record_timesheet[j + 1])
        date = header[j].to_i
        if date > Settings.end_day_pay && date <= Settings.end_of_month
          arr_date = CustomCommon.calculated_month_year month, year
          date = "#{date}#{I18n.t "slash"}#{arr_date[0]}#{I18n.t "slash"}#{arr_date[1]}"
        else
          date = "#{date}#{I18n.t "slash"}#{month}#{I18n.t "slash"}#{year}"
        end
        employee_code = record_timesheet[Settings.col_employee_code]
        timesheet_exist = TimeSheet.load_by_date(Date.parse(date))
          .find_by employee_code: employee_code
        if timesheet_exist.present?
          timesheet_exist.reset_time_in time_in_timesheet
          timesheet_exist.reset_time_out time_out_timesheet
        else
          TimeSheet.create date: date, time_in: time_in_timesheet,
            time_out: time_out_timesheet, employee_code: employee_code
        end
      end
    end

    def read_each_line spreadsheet, header, month, year
      (Settings.data_row_first..spreadsheet.last_row).step(2) do |i|
        record_timesheet = spreadsheet.row i
        user = User.find_by employee_code: record_timesheet[Settings.col_employee_code]
        if user
          add_timesheet spreadsheet, record_timesheet, header, month, year
        end
      end
    end
  end

  def reset_time_in time_in_other
    if time_in.present? && time_in_other.present? && time_in_other < time_in
      update_attributes time_in: time_in_other
    end
  end

  def reset_time_out time_out_other
    if time_out.present? && time_out_other.present? && time_out_other > time_out
      update_attributes time_out: time_out_other
    end
  end
end
