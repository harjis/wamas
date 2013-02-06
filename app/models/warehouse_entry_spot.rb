class WarehouseEntrySpot < ActiveRecord::Base
  has_and_belongs_to_many :warehouse_entries
  belongs_to :warehouse_spot

  accepts_nested_attributes_for :warehouse_entries

  attr_accessible :remaining_spot_quantity, :spot_quantity, :warehouse_spots_attributes, :warehouse_entry_id, :warehouse_spot_id
end
