class CreateRequestLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :request_leaves do |t|
      t.datetime :from
      t.datetime :to
      t.string :reason
      t.integer :status
      t.integer :approve_group
      t.references :leave_type, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
