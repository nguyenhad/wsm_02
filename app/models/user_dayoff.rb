class UserDayoff < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :special_dayoff_type
end
