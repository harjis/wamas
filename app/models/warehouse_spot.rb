class WarehouseSpot < ActiveRecord::Base
  belongs_to :warehouse
  has_many :warehouse_entry_spots
  attr_accessible :level, :position, :row, :warehouse_id
end
