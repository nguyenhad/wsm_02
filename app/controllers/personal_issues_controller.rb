class PersonalIssuesController < ApplicationController
  def index
    @personal_issues = current_user.personal_issues.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end
end
