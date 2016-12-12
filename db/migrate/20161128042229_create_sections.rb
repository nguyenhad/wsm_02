class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections, id: false do |t|
      t.references :workspace, foreign_key: true
      t.string :name
      t.integer :pos_x
      t.integer :pos_y
      t.integer :width
      t.integer :height
      t.string :section_key
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
