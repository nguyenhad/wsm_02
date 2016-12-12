class CreateOtDetailSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :ot_detail_settings do |t|
      t.references :ot_setting, foreign_key: true
      t.time :from_time
      t.time :end_time
      t.integer :wage_rate
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
