class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.references :company, foreign_key: true
      t.time :time_in
      t.time :time_out
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
