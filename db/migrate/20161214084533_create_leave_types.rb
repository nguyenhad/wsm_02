class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.string :description
      t.string :code
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
