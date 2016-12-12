class CreateOtSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :ot_settings do |t|
      t.references :company, foreign_key: true
      t.time :from_time_available
      t.time :end_time_available

      t.timestamps
    end
  end
end
