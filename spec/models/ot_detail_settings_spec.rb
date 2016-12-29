require "rails_helper"

RSpec.describe OtDetailSetting, type: :model do
  context "columns" do
    it{should have_db_column(:from_time).of_type(:time)}
    it{should have_db_column(:end_time).of_type(:time)}
    it{should have_db_column(:wage_rate).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to belong_to :ot_setting}
  end
end
