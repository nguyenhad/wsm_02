class TimesheetService
  attr_accessor :timesheet

  def initialize timesheet, shift, position
    @timesheet = timesheet
    @shift = shift
    @position = position
  end

  def timesheet_inlate? timesheet, shift
    if timesheet.time_in.blank? || timesheet.time_in > shift.time_in
      if holiday? timesheet
        false
      end
        !request_leave? timesheet, LeaveType::LEAVE_CODES[:inlate]
    else
      false
    end
  end

  def timesheet_early_leave? timesheet, shift
    if timesheet.time_in.blank? || timesheet.time_out > shift.time_out
      if holiday? timesheet
        false
      end
        !request_leave? timesheet, LeaveType::LEAVE_CODES[:leave_early]
    else
      false
    end
  end

  def holiday? timesheet
    holiday = Holiday.find_by date: timesheet.date,
      company_id: timesheet.user.company_id
    holiday ? true : false
  end

  def check_object_timesheet
    position.manager?
  end

  private

  def format_to_time time
    time.strftime(Settings.hour_minutes).in_time_zone.utc
  end

  def load_leave_type code_type, company_id
    @leave_type = LeaveType.find_by code: code_type, company_id: company_id
    unless @leave_type
      flash[:danger] = I18n.t("not_found_leave_type")
      return false
    end
  end

  def valid_compensation? compensation, timesheet_compensation
    timesheet_time_out = format_to_time timesheet_compensation.time_out
    compensation_time_to = format_to_time compensation.to
    timesheet_time_out < compensation_time_to ? false : true
  end

  def valid_timesheet_of_compensation? timesheet
    timesheet.blank? ? false : valid_compensation?(compensation, timesheet)
  end

  def compensation? request_leave
    compensation = request_leave.compensation
    if compensation
      timesheet_compensation = TimeSheet.load_by_date(compensation.to.to_date)
        .find_by user_id: request_leave.user.id
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
    load_leave_type code_type, timesheet.user.company_id
    request_leave = @leave_type.request_leaves
      .find_by_date(timesheet.date).find_by user_id: timesheet.user_id
    if request_leave.any?
      valid_request? request_leave.first
    else
      false
    end
  end
end
