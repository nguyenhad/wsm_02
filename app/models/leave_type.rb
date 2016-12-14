class LeaveType < ApplicationRecord
  acts_as_paranoid

  has_many :request_leaves
  has_one :compensation

  belongs_to :leave_setting
end
