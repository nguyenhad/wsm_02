class LeaveSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :company

  def name
    [amount, unit].join(" ")
  end
end
