class Section < ApplicationRecord
  acts_as_paranoid

  belongs_to :workspace
  self.primary_keys = :section_key, :workspace_id
  has_many :locations, class_name: Location.name,
    foreign_key: [:section_key, :workspace_id]

  has_many :location_types, through: :locations

  validates :workspace, presence: true
  validates :section_key, presence: true,
    uniqueness: {scope: :workspace_id}
  validates :name, presence: true,
    length: {maximum: Settings.validation.section.name_max_len}
  validates :pos_x, presence: true, numericality: {only_integer: true}
  validates :pos_y, presence: true, numericality: {only_integer: true}
  validates :width, presence: true, numericality: {only_integer: true}
  validates :height, presence: true, numericality: {only_integer: true}

  scope :find_by_key_and_workspace, ->section_key, workspace_id do
    where section_key: section_key, workspace_id: workspace_id
  end
end
