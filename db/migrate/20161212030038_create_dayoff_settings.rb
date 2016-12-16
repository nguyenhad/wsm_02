class CreateDayoffSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :dayoff_settings do |t|
      t.references :company, foreign_key: true
      t.integer :loop_available, default: true
      t.integer :limmit_loop_year
      t.integer :limmit_loop_day
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
