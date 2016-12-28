class CreateUserDayoffs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_dayoffs do |t|
      t.references :user, foreign_key: true
      t.references :special_dayoff_type, foreign_key: true
      t.integer :year
      t.float :remain
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
