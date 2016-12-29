require "rails_helper"
RSpec.describe LeaveSetting, type: :model do
  context "columns" do
    it{should have_db_column(:amount).of_type(:float)}
    it{should have_db_column(:unit).of_type(:integer)}
    it{should have_db_column(:limit_times).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to belong_to :company}
  end
end
