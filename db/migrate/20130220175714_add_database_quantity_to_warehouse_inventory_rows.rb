class AddDatabaseQuantityToWarehouseInventoryRows < ActiveRecord::Migration
  def change
    add_column :warehouse_inventory_rows, :database_quantity, :float
  end
end
