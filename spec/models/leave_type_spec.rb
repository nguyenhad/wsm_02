require "rails_helper"

RSpec.describe LeaveType, type: :model do
  context "columns" do
    it{should have_db_column(:name).of_type(:string)}
    it{should have_db_column(:description).of_type(:string)}
    it{should have_db_column(:code).of_type(:string)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to have_many :request_leaves}
  end

  context "validates" do
    it {should validate_presence_of(:code)}
    it {should validate_uniqueness_of(:code).case_insensitive}
  end
end
