class CreateWhiteLists < ActiveRecord::Migration[5.0]
  def change
    create_table :white_lists do |t|
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
