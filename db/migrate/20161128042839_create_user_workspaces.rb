class CreateUserWorkspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :user_workspaces do |t|
      t.references :workspace, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_manager, default: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
