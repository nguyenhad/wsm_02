class CreateLeaveSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_settings do |t|
      t.float :amount
      t.integer :unit
      t.integer :limit_times
      t.references :company, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
