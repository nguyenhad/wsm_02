class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.text :description
      t.integer :closest_parent_id
      t.string :parent_path
      t.integer :group_type
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
