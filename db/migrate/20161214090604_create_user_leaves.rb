class CreateUserLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :user_leaves do |t|
      t.float :remain
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
