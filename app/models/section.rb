class Section < ApplicationRecord
  belongs_to :workspace
  has_many :positions, dependent: :destroy
  has_many :position_types, through: :positions
end
