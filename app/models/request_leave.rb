class RequestLeave < ApplicationRecord
  acts_as_paranoid

  has_many :compensations

  belongs_to :leave_type
  belongs_to :user
end
