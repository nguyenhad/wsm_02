class RequestOff < ApplicationRecord
  acts_as_paranoid

  belongs_to :approver, class_name: User.name
  belongs_to :special_dayoff_type
  belongs_to :user

  enum status: {pending: 0, approve: 1, reject: 2}

  ATTR_PARAMS = [:name, :uid, :project, :position, :department, :requeset_date,
    :start_off_on, :finish_off_on, :reason, :start_off_without_pay_on,
    :status, :approver_id, :finish_off_without_pay].freeze
end
