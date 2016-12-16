class CreateCompensations < ActiveRecord::Migration[5.0]
  def change
    create_table :compensations do |t|
      t.datetime :from
      t.datetime :to
      t.references :request_leave, foreign_key: true
      t.integer :status
      t.integer :type
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
