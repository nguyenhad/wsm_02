class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.string :description
      t.string :code
      t.references :leave_setting, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
