class CreateRequestOffs < ActiveRecord::Migration[5.0]
  def change
    create_table :request_offs do |t|
      t.datetime :from
      t.datetime :to
      t.string :reason
      t.references :special_dayoff_type, foreign_key: true
      t.integer :status
      t.integer :approve_group
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
