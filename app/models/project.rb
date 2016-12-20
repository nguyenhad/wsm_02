class Project < ApplicationRecord
  acts_as_paranoid

  has_many :project_members, dependent: :destroy

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true, length: {maximum: Settings.project.name}
  validate :end_date_is_after_start_date

  private
  def end_date_is_after_start_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add :end_date, I18n.t("cannot_be_before_the_start_date")
    end
  end
end
