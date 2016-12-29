require "rails_helper"

RSpec.describe SpecialDayoffType, type: :model do
  context "columns" do
    it{should have_db_column(:name).of_type(:string)}
    it{should have_db_column(:description).of_type(:text)}
    it{should have_db_column(:code).of_type(:string)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to have_many :request_offs}
    it{is_expected.to have_many :special_dayoff_settings}
  end
end
