class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  has_one :shipment_row
  has_and_belongs_to_many :warehouse_entry_spots
  attr_accessible :quantity, :type, :warehouse_entry_id, :warehouse_entry_spots
end
