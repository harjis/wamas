class WarehouseEntrySpot < ActiveRecord::Base
  belongs_to :warehouse_entry
  belongs_to :warehouse_spot
  attr_accessible :remaining_spot_quantity, :spot_quantity, :spot_weight
end
