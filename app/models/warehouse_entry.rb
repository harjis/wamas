class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  has_one :shipment_row
  has_and_belongs_to_many :warehouse_entry_spots
  attr_accessible :quantity, :remaining_quantity, :type, :unit_cost, :warehouse_entry_id
end
