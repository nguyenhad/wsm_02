class LeaveSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :leave_types

  def name
    [amount, unit].join(" ")
  end
end
