class CreateSpecialDayoffSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :special_dayoff_settings do |t|
      t.references :dayoff_setting, foreign_key: true
      t.integer :mount
      t.references :special_dayoff_type, foreign_key: true
      t.integer :unit

      t.timestamps
    end
  end
end
