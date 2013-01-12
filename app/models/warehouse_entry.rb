class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  has_one :shipment_row
  attr_accessible :quantity, :remaining_quantity, :type, :unit_cost
end
