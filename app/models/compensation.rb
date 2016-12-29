class Compensation < ApplicationRecord
  acts_as_paranoid

  belongs_to :request_leave

  enum status: {not_complete: 0, completed: 1}
end
