require "rails_helper"

RSpec.describe OtSetting, type: :model do
  context "columns" do
    it{should have_db_column(:from_time_available).of_type(:time)}
    it{should have_db_column(:end_time_available).of_type(:time)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to have_many :ot_detail_settings}
    it{is_expected.to belong_to :company}
  end
end
