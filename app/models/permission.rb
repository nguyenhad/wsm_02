class Permission < ApplicationRecord
  acts_as_paranoid

  belongs_to :group
end
