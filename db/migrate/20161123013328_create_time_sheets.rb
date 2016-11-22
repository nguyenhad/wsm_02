class CreateTimeSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheets do |t|
      t.string :employee_code
      t.string :staff_name
      t.datetime :date
      t.string :time_in
      t.string :time_out
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
