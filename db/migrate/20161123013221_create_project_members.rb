class CreateProjectMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_members do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :role_scrum, default: 2
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
