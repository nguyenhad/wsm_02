class RequestLeave < ApplicationRecord
  acts_as_paranoid

  has_many :compensations

  belongs_to :leave_type
  belongs_to :user

  enum status: {pendding: 0, approve: 1, reject: 2}
end
