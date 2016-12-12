class CreateWorkspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :description
      t.string :image
      t.boolean :status, default: false
      t.references :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
