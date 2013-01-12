class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  has_one :shipment_row
  has_many :warehouse_entry_spots
  attr_accessible :quantity, :remaining_quantity, :type, :unit_cost
end
