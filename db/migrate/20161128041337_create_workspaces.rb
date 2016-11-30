class CreateWorkspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :description
      t.boolean :status, default: false
      t.references :user, foreign_key: true
    end
  end
end