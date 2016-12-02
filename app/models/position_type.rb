class PositionType < ApplicationRecord
  has_many :positions

  validates :name, presence: true,
    length: {maximum: Settings.validation.position_type.name_max_len}
  validates :color, presence: true,
    length: {maximum: Settings.validation.position_type.color_max_len}
end
