class CreateNormalDayoffSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :normal_dayoff_settings do |t|
      t.string :name
      t.string :operator
      t.string :years
      t.string :count_day
      t.references :dayoff_setting, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
