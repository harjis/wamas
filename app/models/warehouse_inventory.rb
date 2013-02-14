class WarehouseInventory < ActiveRecord::Base
  belongs_to :warehouse
  has_many :warehouse_inventory_rows
  attr_accessible :warehouse_id, :warehouse

  accepts_nested_attributes_for :warehouse_inventory_rows, :allow_destroy => true

  attr_accessible :warehouse_inventory_rows_attributes

end
