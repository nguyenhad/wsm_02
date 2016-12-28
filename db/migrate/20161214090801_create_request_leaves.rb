class CreateRequestLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :request_leaves do |t|
      t.datetime :leave_from
      t.datetime :leave_to
      t.string :reason
      t.integer :status, default: 0
      t.integer :approver_id
      t.integer :leave_type_id
      t.integer :leave_setting_id
      t.integer :user_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :request_leaves, :approver_id
    add_index :request_leaves, :user_id
    add_index :request_leaves,  [:leave_type_id, :leave_setting_id]
  end
end
