class CreateLocationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :location_types do |t|
      t.string :name
      t.string :color
      t.integer :default_width, default: 200
      t.integer :default_height, default: 200
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
