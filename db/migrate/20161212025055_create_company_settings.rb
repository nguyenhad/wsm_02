class CreateCompanySettings < ActiveRecord::Migration[5.0]
  def change
    create_table :company_settings do |t|
      t.integer :cutoff_date
      t.references :company, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
