class TrackingTime
  def initialize request_off
    @request_off = request_off
    @user = @request_off.user
    @current_user_dayoff = @user.user_dayoffs
      .find_by year: @request_off.off_have_salary_from.year
  end

  def update_remaining_time remain
    @current_user_dayoff.update_attributes remain: remain
  end

  def remaining_dayoff_of_user
    @current_user_dayoff.nil? ? 0 : @current_user_dayoff.remain
  end

  def update_remaining_time_of_user_dayoffs
    number_of_dayoff = remaining_dayoff_of_user - number_of_dayoffs
    if number_of_dayoff < remaining_dayoff_of_user && number_of_dayoff > 0
      update_remaining_time number_of_dayoff
    end
  end

  def number_of_dayoffs
    dayoff_from = @request_off.off_have_salary_from
    dayoff_to = @request_off.off_have_salary_to
    (dayoff_to - dayoff_from) / Settings.seconds_in_day
  end
end
