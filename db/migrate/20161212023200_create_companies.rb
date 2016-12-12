class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :parent_id
      t.integer :status
      
      t.timestamps
    end
  end
end
