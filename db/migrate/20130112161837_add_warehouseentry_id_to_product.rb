class AddWarehouseentryIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :warehouseentry_id, :integer
  end
end
