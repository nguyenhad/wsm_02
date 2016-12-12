class CreateCompensations < ActiveRecord::Migration[5.0]
  def change
    create_table :compensations do |t|
      t.date :from
      t.date :to
      t.references :request_off, foreign_key: true
      t.integer :status
      t.integer :type

      t.timestamps
    end
  end
end
