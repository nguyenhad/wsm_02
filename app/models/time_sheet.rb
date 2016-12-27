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
  scope :load_by_date, ->date{where date: date}
  scope :by_period_days, ->period_dates do
    where date: period_dates
  end

  class << self
    def import file, timesheet_setting, month, year
      @spreadsheet = open_spreadsheet file
      return false unless @spreadsheet
      @timesheet_setting = timesheet_setting
      @month = month
      @year = year
      @optional_settings = @timesheet_setting.optional_settings
      import_follow_setting
    end

    private

    def import_follow_setting
      get_arange_date_end_start
      if @timesheet_setting.horizontal?
        check_type_import_horizontal
      else
        check_type_import_vertical
      end
    end

    def check_type_import_horizontal
      @list_dates = @arange_dates.to_a
      if @timesheet_setting.title?
        read_file_horizontal_with_title
      else
        read_file_horizontal_with_serial
      end
    end

    def check_type_import_vertical
      if @timesheet_setting.title?
        read_file_vertical_with_title
      else
        import_data_vertical_with_serial
      end
    end

    def get_arange_date_end_start
      company = @timesheet_setting.company
      company_setting = company.company_setting
      @arange_dates = UserTimeSheetService.new(company, @month, @year)
        .get_begin_and_end_of_cut_off(company_setting.cutoff_date, @month, @year)
    end

    def read_each_line_header_horizontal row_header
      row_header.each_with_index do |item, index|
        check_horizontal_title_optional item, index
      end
      get_number_column_inprocess
      import_data_horizontal unless invalid_horizontal_optinal?
    end

    def read_file_horizontal_with_title
      get_title_horizontal_optional_settings
      (@spreadsheet.first_row..(@timesheet_setting.start_row_data - 1)).each do |i|
        record_header = @spreadsheet.row i
        next unless record_header.blank?
        read_each_line_header_horizontal record_header
      end
    end

    def read_file_horizontal_with_serial
      set_num_col_process_horizontal_serial
      import_data_horizontal unless invalid_horizontal_optinal?
    end

    def invalid_horizontal_optinal?
      @num_col_key.blank? || @num_col_start_date.blank? ||
        @num_col_end_date.blank?
    end

    def import_data_horizontal
      (@timesheet_setting.start_row_data..@spreadsheet.last_row).each do |i|
        record_data_timesheet = @spreadsheet.row i
        user = find_user record_data_timesheet[@num_col_key]
        next unless user
        import_data_horizontal_of_user user, record_data_timesheet
      end
    end

    def load_time_in_out row, i
      [
        CustomCommon.format_unix_to_time(row[i]),
        CustomCommon.format_unix_to_time(row[i + 1])
      ]
    end

    def import_data_horizontal_of_user user, record_data_timesheet
      (@num_col_start_date..@num_col_end_date).step(2) do |j|
        time_in, time_out = load_time_in_out(record_data_timesheet, j)
        next if time_in.blank? && time_out.blank?
        date = get_date_of_timesheet j
        add_timesheet user, date, time_in, time_out
      end
    end

    def add_timesheet user, date, time_in, time_out
      timesheet_by_date = user.time_sheets.find_by date: date
      if timesheet_by_date.present?
        timesheet_by_date.reset_time_in time_in
        timesheet_by_date.reset_time_out time_out
      else
        user.time_sheets.create date: date, time_in: time_in, time_out: time_out
      end
    end

    def set_num_col_process_horizontal_serial
      @num_col_start_date = @optional_settings[:date] - 1
      return if @num_col_start_date.blank? || @list_dates.blank?
      @num_col_end_date = @list_dates.length * 2 + @num_col_start_date - 1
      set_num_col_key
    end

    def set_num_col_key
      case @optional_settings[:key]
      when Settings.employee_code_attribute
        @num_col_key = @optional_settings[:employee_code] - 1
      when Settings.name_attribute
        @num_col_key = @optional_settings[:name] - 1
      else
        false
      end
    end

    def get_title_horizontal_optional_settings
      @title_date = @optional_settings[:date]
      case @optional_settings[:key]
      when Settings.employee_code_attribute
        @title_key = @optional_settings[:employee_code]
      when Settings.name_attribute
        @title_key = @optional_settings[:name]
      else
        return false
      end
    end

    def check_horizontal_title_optional item, index
      case item.to_s.strip
      when @title_key
        @num_col_key = index
      when @title_date
        @num_col_start_date = index
      end
    end

    def get_number_column_inprocess
      return if @num_col_start_date.blank? || @list_dates.blank?
      @num_col_end_date = @list_dates.length * 2 + @num_col_start_date - 1
    end

    def get_date_of_timesheet index
      if index == @num_col_start_date
        @list_dates[index - @num_col_start_date]
      else
        @list_dates[(index - @num_col_start_date) / 2]
      end
    end

    def get_title_vertical_optional_settings
      @title_date = @optional_settings[:date]
      @title_time_in = @optional_settings[:time_in]
      @title_time_out = @optional_settings[:time_out]
      case @optional_settings[:key]
      when Settings.employee_code_attribute
        @title_key = @optional_settings[:employee_code]
      when Settings.name_attribute
        @title_key = @optional_settings[:name]
      else
        return false
      end
    end

    def check_vertical_title_optional item, index
      case item.to_s.strip
      when @title_key
        @num_col_key = index
      when @title_date
        @num_col_date = index
      when @title_time_in
        @num_col_time_in = index
      when @title_time_out
        @num_col_time_out = index
      end
    end

    def invalid_optinal?
      @num_col_key.blank? || @num_col_date.blank? ||
        @num_col_time_in.blank? || @num_col_time_out.blank?
    end

    def find_user value
      case @optional_settings[:key]
      when Settings.employee_code_attribute
        User.find_by employee_code: value,
          company_id: @timesheet_setting.company_id
      when Settings.name_attribute
        User.find_by name: value, company_id: @timesheet_setting.company_id
      end
    end

    def valid_date? date
      if date.is_a? Date
        date
      else
        CustomCommon.format_string_to_date date,
          @timesheet_setting.date_format_type
      end
    end

    def format_time_vertical string_time
      return "" if string_time.blank?
      CustomCommon.format_string_to_time(string_time)
    end

    def load_date_time_in_out_vertical row_data
      [
        valid_date?(row_data[@num_col_date]),
        format_time_vertical(row_data[@num_col_time_in]),
        format_time_vertical(row_data[@num_col_time_out])
      ]
    end

    def invalid_data_import_vertical? date, time_in, time_out
      !@arange_dates.include?(date) || (time_in.blank? && time_out.blank?)
    end

    def import_data_vertical
      (@timesheet_setting.start_row_data..@spreadsheet.last_row).each do |i|
        record_data_timesheet = @spreadsheet.row i
        user = find_user record_data_timesheet[@num_col_key]
        next unless user
        date, time_in, time_out = load_date_time_in_out_vertical record_data_timesheet
        next if invalid_data_import_vertical?(date, time_in, time_out)
        add_timesheet user, date, time_in, time_out
      end
    end

    def read_each_line_header_vertical_title row_header
      row_header.each_with_index do |item, index|
        check_vertical_title_optional item, index
      end
    end

    def read_file_vertical_with_title
      get_title_vertical_optional_settings
      (@spreadsheet.first_row..(@timesheet_setting.start_row_data - 1)).each do |i|
        record_header = @spreadsheet.row i
        next if row_header.blank?
        read_each_line_header_vertical_title record_header
        next if invalid_optinal?
        import_data_vertical
      end
    end

    def set_number_column_process_vertical
      @num_col_date = @optional_settings[:date] - 1
      @num_col_time_in = @optional_settings[:time_in] - 1
      @num_col_time_out = @optional_settings[:time_out] - 1
      set_num_col_key
    end

    def import_data_vertical_with_serial
      set_number_column_process_vertical
      import_data_vertical
    end
  end

  def reset_time_in time_in
    if (self.time_in.present? && time_in.present? &&
      CustomCommon.format_string_to_time(time_in) < self.time_in) ||
       (self.time_in.blank? && time_in.present?)
      update_attributes time_in: time_in
    end
  end

  def reset_time_out time_out
    if (self.time_out.present? && time_out.present? &&
      CustomCommon.format_string_to_time(time_out) > self.time_out) ||
       (self.time_out.blank? && time_out.present?)
      update_attributes time_out: time_out
    end
  end
end
