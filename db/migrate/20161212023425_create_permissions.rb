class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :entry
      t.string :optional
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
