class CreateCompensations < ActiveRecord::Migration[5.0]
  def change
    create_table :compensations do |t|
      t.datetime :from
      t.datetime :to
      t.integer :status, default: 0
      t.integer :type
      t.references :request_leave, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
