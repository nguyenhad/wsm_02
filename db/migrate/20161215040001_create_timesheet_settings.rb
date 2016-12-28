class CreateTimesheetSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheet_settings do |t|
      t.integer :layout_type
      t.integer :value_type
      t.string :optional_settings
      t.integer :start_row_data
      t.string :date_format_type, default: "%d/%m/%Y"
      t.datetime :deleted_at
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
