class ShipmentRow < ActiveRecord::Base
  belongs_to :shipment
  belongs_to :sales_order_row
  belongs_to :warehouse_entry
  attr_accessible :sales_order_row_id, :shipped_quantity, :total_amount, :unit_price
end
