class Position < ApplicationRecord
  belongs_to :section
  belongs_to :position_types
  belongs_to :user
end
