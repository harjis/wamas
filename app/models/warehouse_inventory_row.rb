class WarehouseInventoryRow < ActiveRecord::Base
  belongs_to :warehouse_inventory
  belongs_to :warehouse_entry
  # attr_accessible :title, :body
end
