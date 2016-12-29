class WhiteList < ApplicationRecord
  belongs_to :company
  serialize :list_user, Array
end
