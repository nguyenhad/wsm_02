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

  def manager?
    [Position::POSITION_TYPE[:ceo], Position::POSITION_TYPE[:dm],
      Position::POSITION_TYPE[:sm]].include?(name)
  end
end
