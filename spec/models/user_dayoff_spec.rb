require "rails_helper"
RSpec.describe UserDayoff, type: :model do
  context "columns" do
    it{should have_db_column(:remain).of_type(:float)}
    it{should have_db_column(:year).of_type(:integer)}
    it{should have_db_column(:special_dayoff_type_id).of_type(:integer)}
    it{should have_db_column(:user_id).of_type(:integer)}
    it{should have_db_column(:year).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :special_dayoff_type}
  end
end

