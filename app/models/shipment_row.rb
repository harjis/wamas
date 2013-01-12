class ShipmentRow < ActiveRecord::Base
  belongs_to :shipment
  belongs_to :warehouse_entry
  attr_accessible :discount_amount, :discount_amount_lcy, :discount_percent, :shipment_row_number, :shipped_quantity, :total_amount, :total_amount_lcy, :unit_cost, :unit_price, :unit_price_lcy
end
