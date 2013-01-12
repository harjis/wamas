class CreateWarehouseEntrySpots < ActiveRecord::Migration
  def change
    create_table :warehouse_entry_spots do |t|
      t.references :warehouse_entry
      t.references :warehouse_spot
      t.float :spot_weight
      t.integer :spot_quantity
      t.integer :remaining_spot_quantity

      t.timestamps
    end
    add_index :warehouse_entry_spots, :warehouse_entry_id
    add_index :warehouse_entry_spots, :warehouse_spot_id
  end
end
