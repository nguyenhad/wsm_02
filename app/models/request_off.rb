class RequestOff < ApplicationRecord
  acts_as_paranoid

  belongs_to :approver, class_name: User.name
  belongs_to :special_dayoff_type
  belongs_to :user

  enum status: {pending: 0, approve: 1, reject: 2}

  delegate :name, to: :user, prefix: true

  ATTR_PARAMS = [
    :company_id,
    :project_name,
    :position_name,
    :department,
    :request_date,
    :off_no_salary_from,
    :off_no_salary_to,
    :off_have_salary_from,
    :off_have_salary_to,
    :special_dayoff_setting_id,
    :special_dayoff_type_id,
    :reason,
    :status,
    :approver_id
  ].freeze
end
