class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.references :workspace, foreign_key: true
      t.string :name
      t.integer :pos_x
      t.integer :pos_y
      t.integer :width
      t.integer :height
    end
  end
end
