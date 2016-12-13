class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :location_type, foreign_key: true
      t.references :user, foreign_key: true, null: true
      t.integer :pos_x
      t.integer :pos_y
      t.integer :width
      t.integer :height
      t.string :section_key
      t.integer :workspace_id
      t.string :location_key
      t.datetime :deleted_at

      t.timestamp
    end
  end
end
