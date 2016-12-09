class Position < ApplicationRecord
  belongs_to :section, foreign_key: [:section_key, :workspace_id]
  belongs_to :position_type
  belongs_to :user, optional: true

  validates :section_key, presence: true
  validates :position_type, presence: true
  validates :pos_x, presence: true, numericality: {only_integer: true}
  validates :pos_y, presence: true, numericality: {only_integer: true}
  validates :width, presence: true, numericality: {only_integer: true}
  validates :height, presence: true, numericality: {only_integer: true}

  scope :of_user, ->user_id do
    where user_id: user_id
  end

  scope :of_workspace, ->workspace_id do
    where workspace_id: workspace_id
  end
end
