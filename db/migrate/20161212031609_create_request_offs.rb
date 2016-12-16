class CreateRequestOffs < ActiveRecord::Migration[5.0]
  def change
    create_table :request_offs do |t|
      t.date :request_date
      t.string :phone_number
      t.string :address_contact
      t.datetime :off_have_salary_from
      t.datetime :off_have_salary_to
      t.references :special_dayoff_setting, foreign_key: true
      t.datetime :off_no_salary_from
      t.datetime :off_no_salary_to
      t.string :reason
      t.references :special_dayoff_type, foreign_key: true
      t.integer :user_handover
      t.string :part_handover
      t.string :work_handover
      t.integer :status
      t.integer :approve_group
      t.references :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
