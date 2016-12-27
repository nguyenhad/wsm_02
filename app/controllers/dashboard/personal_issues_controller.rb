class Dashboard::PersonalIssuesController < DashboardController
  load_and_authorize_resource

  def index
    @personal_issues = @personal_issues.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end
end
