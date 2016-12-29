class LeaveType < ApplicationRecord
  acts_as_paranoid

  LEAVE_CODES = {
    inlate: "IL",
    leave_out: "LO",
    leave_early: "LE",
    inlate_afternoon: "IL(A)"
  }.freeze

  has_many :request_leaves, class_name: RequestLeave.name

  validates :code, presence: true, uniqueness: {case_sensitive: false}
end
