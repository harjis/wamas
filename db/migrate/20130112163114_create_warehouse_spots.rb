class CreateWarehouseSpots < ActiveRecord::Migration
  def change
    create_table :warehouse_spots do |t|
      t.references :warehouse
      t.string :row
      t.integer :level
      t.integer :position

      t.timestamps
    end
    add_index :warehouse_spots, :warehouse_id
  end
end
