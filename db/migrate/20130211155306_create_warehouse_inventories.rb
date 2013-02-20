class CreateWarehouseInventories < ActiveRecord::Migration
  def change
    create_table :warehouse_inventories do |t|
      t.references :warehouse

      t.timestamps
    end
    add_index :warehouse_inventories, :warehouse_id
  end
end
