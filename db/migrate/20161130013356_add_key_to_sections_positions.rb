class AddKeyToSectionsPositions < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :position_key, :string, index: true
  end
end
