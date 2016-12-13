class LocationType < ApplicationRecord
  acts_as_paranoid

  has_many :locations

  validates :name, presence: true,
    length: {maximum: Settings.validation.location_type.name_max_len}
  validates :color, presence: true,
    length: {maximum: Settings.validation.location_type.color_max_len}
end
