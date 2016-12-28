require "rails_helper"
RSpec.describe RequestOff, type: :model do
  context "columns" do
    it{should have_db_column(:request_date).of_type(:date)}
    it{should have_db_column(:project_name).of_type(:string)}
    it{should have_db_column(:position_name).of_type(:string)}
    it{should have_db_column(:phone_number).of_type(:string)}
    it{should have_db_column(:department).of_type(:string)}
    it{should have_db_column(:address_contact).of_type(:string)}
    it{should have_db_column(:off_have_salary_from).of_type(:datetime)}
    it{should have_db_column(:off_have_salary_to).of_type(:datetime)}
    it{should have_db_column(:off_no_salary_from).of_type(:datetime)}
    it{should have_db_column(:off_no_salary_to).of_type(:datetime)}
    it{should have_db_column(:reason).of_type(:string)}
    it{should have_db_column(:user_handover).of_type(:integer)}
    it{should have_db_column(:work_handover).of_type(:string)}
    it{should have_db_column(:status).of_type(:integer)}
    it{should have_db_column(:approver_id).of_type(:integer)}
    it{should have_db_column(:deleted_at).of_type(:datetime)}
    it{should have_db_column(:company_id).of_type(:integer)}
  end

  context "relationship" do
    it{is_expected.to belong_to :approver}
    it{is_expected.to belong_to :special_dayoff_type}
    it{is_expected.to belong_to :user}
  end

  context "validates" do
    it{expect respond_to(:status)}
  end

  describe "delegate" do
    it{should delegate_method(:name).to(:user).with_prefix true}
  end
end
