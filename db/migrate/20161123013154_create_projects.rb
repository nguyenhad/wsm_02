class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
