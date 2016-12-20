class RequestLeave < ApplicationRecord
  acts_as_paranoid

  has_one :compensation

  belongs_to :leave_type
  belongs_to :user

  enum status: {pendding: 0, approve: 1, reject: 2}

  scope :find_by_date, ->(date){where "DATE(request_leaves.to) = ?", date}
end
