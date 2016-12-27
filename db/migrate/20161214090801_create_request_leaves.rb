class CreateRequestLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :request_leaves do |t|
      t.datetime :leave_from
      t.datetime :leave_to
      t.string :reason
      t.integer :status, default: 0
      t.integer :approver_id
      t.references :leave_type, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :request_leaves, :approver_id
  end
end
