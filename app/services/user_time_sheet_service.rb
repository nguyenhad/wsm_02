class UserTimeSheetService

  def initialize company, month, year
    @users = company.users
    @month = month
    @year = year
    @company = company
    @leave_type = LeaveType.all
  end

  def build_hash_timesheet
    cutoff_date = @company.company_setting.cutoff_date
    shift = @company.shift
    date_of_month = get_begin_and_end_of_cut_off(cutoff_date, @month, @year)
    array_date_of_month = date_of_month.to_a
    user_time_sheets = user_time_sheets_hash array_date_of_month
    all_timesheets = TimeSheet.by_period_days(date_of_month)
    user_time_sheets[:usertimesheets] = @users.map do |user|
      times = {}
      array_date_of_month.each do |time|
        time_sheet_user = all_timesheets.find do |k|
          k.date == time && k.user.id == user.id
        end
        time_sheet = if time_sheet_user
          time_sheet_hash time_sheet_user, shift, @company
        else
          {}
        end
        times.merge!({"#{time.strftime('%d-%m-%Y')}": time_sheet})
      end
      {user: UserSerializer.new(user), timesheets: times}
    end
    user_time_sheets
  end

  def get_begin_and_end_of_cut_off(day, month, year)
    date = Date.new(year.to_i, month.to_i).end_of_month.strftime("%d").to_i
    if(day.to_i < date.to_i)
      if (month.to_i == 1)
        month_cut_off_jan day, month, year
      else
        month_cut_off_not_jan day, month, year
      end
    else
      day_cut_off_more_today day, month, year
    end
  end

  private

  def time_sheet_hash time_sheet_user, shift, company
    {
      time_sheet_date: TimeSheetSerializer.new(time_sheet_user),
      timesheet_inlate: TimesheetService.new(time_sheet_user, shift, company, @leave_type)
                                        .timesheet_inlate?,
      timesheet_early_leave: TimesheetService.new(time_sheet_user,
                                                  shift, company, @leave_type)
                                             .timesheet_early_leave?,
      holiday: TimesheetService.new(time_sheet_user, shift, company, @leave_type)
                               .holiday?(time_sheet_user)
    }
  end

  def user_time_sheets_hash array_date_of_month
    {
      date_of_month: array_date_of_month,
      month: "#{@year}/#{@month}",
      usertimesheets: []
    }
  end

  def month_cut_off_jan day, month, year
    date_begin_12 = Date.new(year.to_i - 1, 12)
                    .end_of_month.strftime("%d").to_i
    if (day.to_i < date_begin_12.to_i)
      begin_of_month = Date.new(year.to_i - 1, 12, day.to_i + 1)
    else
      begin_of_month = Date.new(year.to_i - 1, 12, date_begin_12.to_i)
    end
    end_of_month = Date.new(year.to_i,month.to_i,day.to_i)
    begin_of_month..end_of_month
  end

  def month_cut_off_not_jan day, month, year
    begin_of_month = get_begin_of_month_from_date_back_month day, month, year
    end_of_month = Date.new(year.to_i, month.to_i,day.to_i)
    begin_of_month..end_of_month
  end

  def day_cut_off_more_today day, month, year
    if(month.to_i == 1)
      begin_of_month = Date.new(year.to_i, month.to_i, 1)
      end_of_month = Date.new(year.to_i, month.to_i, date.to_i)
    else
      begin_of_month = get_begin_of_month_from_date_back_month day, month, year
      end_of_month = Date.new(year.to_i, month.to_i, date.to_i)
    end
    begin_of_month..end_of_month
  end

  def get_begin_of_month_from_date_back_month day, month, year
    date_back_month = Date.new(year.to_i, month.to_i - 1)
                          .end_of_month.strftime("%d").to_i
    begin_of_month = if(day.to_i < date_back_month.to_i)
      Date.new(year.to_i, month.to_i - 1, day.to_i + 1)
    else
      Date.new(year.to_i, month.to_i,1)
    end
  end
end
