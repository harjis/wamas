class AddCountedQuantityToWarehouseInventoryRows < ActiveRecord::Migration
  def change
    add_column :warehouse_inventory_rows, :counted_quantity, :integer
  end
end
