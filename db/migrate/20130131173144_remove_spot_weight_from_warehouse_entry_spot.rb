class RemoveSpotWeightFromWarehouseEntrySpot < ActiveRecord::Migration
  def up
    remove_column :warehouse_entry_spots, :spot_weight
  end

  def down
    add_column :warehouse_entry_spots, :spot_weight, :float
  end
end
