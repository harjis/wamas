class WarehouseInventoryRow < ActiveRecord::Base
  belongs_to :warehouse_inventory
  belongs_to :warehouse_entry
  has_one :product, :through => :warehouse_entry

  attr_accessible :warehouse_entry, :product, :counted_quantity
end
