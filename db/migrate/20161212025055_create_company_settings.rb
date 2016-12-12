class CreateCompanySettings < ActiveRecord::Migration[5.0]
  def change
    create_table :company_settings do |t|
      t.integer :limit_leave 
      t.integer :cutoff_date 
      t.integer :limit_time_leave 
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
