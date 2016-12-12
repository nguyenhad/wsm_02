class CreateSpecialDayoffTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :special_dayoff_types do |t|
      t.string :name
      t.text :description
      t.string :code
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
