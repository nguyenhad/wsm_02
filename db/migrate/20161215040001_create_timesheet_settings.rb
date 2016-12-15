class CreateTimesheetSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheet_settings do |t|
      t.integer :layout_type
      t.integer :value_type
      t.string :optional_settings
      t.date :start_date
      t.date :end_date
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
