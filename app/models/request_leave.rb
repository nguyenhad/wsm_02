class RequestLeave < ApplicationRecord
  self.table_name = "request_leaves"

  acts_as_paranoid

  has_one :compensation

  belongs_to :approver, class_name: User.name
  belongs_to :leave_type
  belongs_to :user

  delegate :name, to: :leave_type, prefix: true
  delegate :name, to: :user, prefix: true

  enum status: {pendding: 0, approve: 1, reject: 2}
  scope :find_by_date, ->(date){where "DATE(leave_to) = ?", date}

  accepts_nested_attributes_for :compensation

  def time_leave
    ((compensation.to - compensation.from) / 60).round
  end

  ATTR_PARAMS = [:status, :approver_id].freeze
end
