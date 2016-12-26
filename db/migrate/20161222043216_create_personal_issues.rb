class CreatePersonalIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :personal_issues do |t|
      t.string :phone_number
      t.string :address_contact
      t.datetime :off_no_salary_from
      t.datetime :off_no_salary_to
      t.string :reason
      t.integer :user_id
      t.integer :company_id
      t.integer :user_handover
      t.string :part_handover
      t.string :work_handover
      t.timestamps

    end
  end
end
