class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.string :description
      t.string :code
      t.integer :company_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :leave_types, :company_id
  end
end
