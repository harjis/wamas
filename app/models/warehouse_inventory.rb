class WarehouseInventory < ActiveRecord::Base
  belongs_to :warehouse
  has_many :warehouse_inventory_rows
  attr_accessible :warehouse_id
end
