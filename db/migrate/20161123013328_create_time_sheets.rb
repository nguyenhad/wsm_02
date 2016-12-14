class CreateTimeSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheets do |t|
      t.string :employee_code
      t.datetime :date
      t.time :time_in
      t.time :time_out
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
