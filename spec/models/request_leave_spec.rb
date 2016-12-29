require "rails_helper"
RSpec.describe RequestLeave, type: :model do
  context "columns" do
    it{should have_db_column(:leave_from).of_type(:datetime)}
    it{should have_db_column(:leave_to).of_type(:datetime)}
    it{should have_db_column(:reason).of_type(:string)}
    it{should have_db_column(:status).of_type(:integer)}
    it{should have_db_column(:approver_id).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to belong_to :approver}
    it{is_expected.to belong_to :leave_type}
    it{is_expected.to belong_to :user}
    it{is_expected.to have_one :compensation}
  end

  describe "delegate" do
    it{should delegate_method(:name).to(:user).with_prefix true}
    it{should delegate_method(:name).to(:leave_type).with_prefix true}
  end

  context "validates" do
    it{should define_enum_for(:status).with([:pending, :approve, :reject])}
  end

  describe "attributes" do
    it{should accept_nested_attributes_for(:compensation)}
  end
end
