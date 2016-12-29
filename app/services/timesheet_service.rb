class TimesheetService
  def initialize timesheet, shift, company, leave_type
    @timesheet = timesheet
    @shift = shift
    @company = company
    @leave_type = leave_type
    @holidays = company.holidays
    @request_leaves = RequestLeave.find_by_date timesheet.date
  end

  def timesheet_inlate?
    if @timesheet.time_in.blank? ||
       CustomCommon.convert_in_time_zone(@timesheet.time_in.in_time_zone) >
       CustomCommon.convert_in_time_zone(@shift.time_in)
      check_leave_type LeaveType::LEAVE_CODES[:inlate]
    else
      false
    end
  end

  def timesheet_early_leave?
    if @timesheet.time_out.blank? ||
       CustomCommon.convert_in_time_zone(@timesheet.time_out.in_time_zone) <
       CustomCommon.convert_in_time_zone(@shift.time_out)
      check_leave_type LeaveType::LEAVE_CODES[:leave_early]
    else
      false
    end
  end

  def check_leave_type type
    return false if holiday? @timesheet
    !request_leave? @timesheet, type
  end

  def holiday? timesheet
    holiday = @holidays.find do |h|
      h.date == timesheet.date && h.company_id == timesheet.user.company_id
    end
    holiday ? true : false
  end

  private

  def format_to_time time
    time.strftime(Settings.hour_minutes).in_time_zone
  end

  def valid_compensation? compensation, timesheet_compensation
    timesheet_time_out = format_to_time timesheet_compensation.time_out
    compensation_time_to = format_to_time compensation.to
    timesheet_time_out < compensation_time_to ? false : true
  end

  def valid_timesheet_of_compensation?
    @timesheet.blank? ? false : valid_compensation?(compensation, @timesheet)
  end

  def compensation? request_leave
    compensation = request_leave.compensation
    if compensation
      timesheet_compensation = @timesheet.find do |t|
        t.date == compensation.to.to_date && t.user_id == request_leave.user.id
      end
      valid_timesheet_of_compensation? timesheet_compensation
    else
      false
    end
  end

  def valid_request? request_leave
    if request_leave.status == RequestLeave.statuses.keys[1]
      compensation? request_leave
    else
      false
    end
  end

  def request_leave? timesheet, code_type
    leave_type = @leave_type.find{|k| k.code == code_type}
    return false unless leave_type && @request_leaves
    request_leave = @request_leaves.find do |h|
      h.to == timesheet.date && h.leave_type_id == leave_type.id
    end
    return false unless request_leave
    valid_request? request_leave.first
  end
end
