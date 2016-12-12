class CreateHolidays < ActiveRecord::Migration[5.0]
  def change
    create_table :holidays do |t|
      t.integer :type
      t.date :date
      t.references :company, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
