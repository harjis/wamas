class WarehouseInventoryRow < ActiveRecord::Base
  belongs_to :warehouse_inventory
  belongs_to :warehouse_entry
  has_one :product, :through => :warehouse_entry

  attr_accessible :warehouse_entry, :product, :counted_quantity, :warehouse_entry_spot_id, :product_id, :name, :database_quantity

  #these are here so that we can use them in a view form helper
  attr_accessor :quantity, :name, :product_id, :warehouse_entry_spot_id, :product_id

  def populate_by_entry_spot(entry_spot)
    self.warehouse_entry_spot_id = entry_spot.id
    self.product_id = entry_spot.warehouse_entries[0].product.id
    self.name = entry_spot.warehouse_entries[0].product.name
    self.database_quantity = entry_spot.remaining_spot_quantity
  end
end
