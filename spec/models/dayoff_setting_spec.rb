require "rails_helper"

RSpec.describe DayoffSetting, type: :model do
  context "columns" do
    it{should have_db_column(:loop_available).of_type(:integer)}
    it{should have_db_column(:limmit_loop_year).of_type(:integer)}
    it{should have_db_column(:limmit_loop_day).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to have_many :special_dayoff_settings}
    it{is_expected.to have_many :normal_dayoff_settings}
    it{is_expected.to belong_to :company}
  end
end
