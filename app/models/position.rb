class Position < ApplicationRecord
  POSITION_TYPE = {
    ceo: "CEO",
    dm: "DivisonManager",
    sm: "SectionManager",
    gl: "GroupLeader",
    leader: "Leader",
    staff: "Staff"
  }.freeze

  acts_as_paranoid

  has_many :users
end
