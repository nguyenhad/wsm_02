class CreatePersonalIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :personal_issues do |t|
      t.string :division_name
      t.string :phone_number
      t.string :address_contact
      t.date :off_no_salary_from
      t.date :off_no_salary_to
      t.integer :in_time, default: 1
      t.integer :unit
      t.string :reason
      t.integer :user_id
      t.integer :company_id
      t.string :user_handover
      t.string :part_handover
      t.string :work_handover
      t.timestamps
    end

    add_index :personal_issues, [:user_id, :company_id]
  end
end
