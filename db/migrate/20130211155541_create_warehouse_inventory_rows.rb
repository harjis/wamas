class CreateWarehouseInventoryRows < ActiveRecord::Migration
  def change
    create_table :warehouse_inventory_rows do |t|
      t.references :warehouse_inventory
      t.references :warehouse_entry

      t.timestamps
    end
    add_index :warehouse_inventory_rows, :warehouse_inventory_id
    add_index :warehouse_inventory_rows, :warehouse_entry_id
  end
end
