class CreateWhiteLists < ActiveRecord::Migration[5.0]
  def change
    create_table :white_lists do |t|
      t.references :company, foreign_key: true
      t.text :list_user

      t.timestamps
    end
  end
end
