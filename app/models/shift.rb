class Shift < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
end
