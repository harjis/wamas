class WarehouseInventoryRow < ActiveRecord::Base
  belongs_to :warehouse_inventory
  belongs_to :warehouse_entry
  has_one :product, :through => :warehouse_entry

  attr_accessible :warehouse_entry, :product, :counted_quantity

  #these are here so that we can use them in a view form helper
  attr_accessor :name, :database_quantity, :quantity, :warehouse_entry_spot_id
end
