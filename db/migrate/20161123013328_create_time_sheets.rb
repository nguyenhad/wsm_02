class CreateTimeSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheets do |t|
      t.date :date
      t.time :time_in
      t.time :time_out
      t.integer :type
      t.datetime :deleted_at
      t.integer :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
