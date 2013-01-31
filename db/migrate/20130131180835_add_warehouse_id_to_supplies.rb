class AddWarehouseIdToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :warehouse_id, :string
  end
end
