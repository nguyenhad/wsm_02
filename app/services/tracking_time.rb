class TrackingTime
  def initialize object
    @request = object
    @user = object.user
    if @request.class.name == RequestOff.name
      @current_user_dayoff = @user.user_dayoffs
        .find_by year: @request.off_have_salary_from.year
    else
      @current_user_leave = @user.user_leaves
        .find_by month: @request.leave_to.month
    end
  end

  def update_remaining_time remain
    if @request.class.name == RequestOff.name
      @current_user_dayoff.update_attributes remain: remain
    else
      @current_user_leave.update_attributes remain: remain
    end
  end

  def remaining_dayoff_of_user
    @current_user_dayoff.nil? ? 0 : @current_user_dayoff.remain
  end

  def remaining_leave_of_user
    @current_user_leave.nil? ? 0 : @current_user_leave.remain
  end

  def update_remaining_time_of_user_dayoffs
    number_of_dayoff = remaining_dayoff_of_user - number_of_dayoffs
    if number_of_dayoff < remaining_dayoff_of_user && number_of_dayoff > 0
      update_remaining_time number_of_dayoff
    end
  end

  def update_remaining_time_of_user_leave
    number_of_leave = remaining_leave_of_user - 1
    if number_of_leave >= 0
      update_remaining_time number_of_leave
    end
  end

  def number_of_dayoffs
    dayoff_from = @request.off_have_salary_from
    dayoff_to = @request.off_have_salary_to
    (dayoff_to - dayoff_from) / Settings.seconds_in_day
  end
end
