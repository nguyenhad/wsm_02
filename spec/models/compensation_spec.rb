require "rails_helper"

RSpec.describe Compensation, type: :model do
  context "columns" do
    it{should have_db_column(:from).of_type(:datetime)}
    it{should have_db_column(:to).of_type(:datetime)}
    it{should have_db_column(:status).of_type(:integer)}
    it{should have_db_column(:type).of_type(:integer)}
    it{should have_db_column(:request_leave_id).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to belong_to :request_leave}
  end

  context "validates" do
    it{should define_enum_for(:status).with([:not_complete, :completed])}
  end
end
