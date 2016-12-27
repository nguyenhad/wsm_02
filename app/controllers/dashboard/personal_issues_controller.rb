class Dashboard::PersonalIssuesController < DashboardController
  load_and_authorize_resource

  def index
    @personal_issues = @personal_issues.page(params[:page])
      .per Settings.per_page.dashboard.request_off
  end

  def new; end

  def create
    @personal_issue.user = current_user

    if @personal_issue.save
      redirect_to dashboard_personal_issues_url,
        notice: flash_message(:create, PersonalIssue)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @personal_issue.update personal_issue_params
      redirect_to dashboard_personal_issues_url,
        notice: flash_message(:update, PersonalIssue)
    else
      render :edit
    end
  end

  private

  def personal_issue_params
    params.require(:personal_issue).permit PersonalIssue::ATTR_PARAMS
  end
end
