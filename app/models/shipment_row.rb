class ShipmentRow < ActiveRecord::Base
  belongs_to :shipment
  belongs_to :sales_order_row
  belongs_to :warehouse_entry
  attr_accessible :sales_order_row_id, :shipped_quantity, :total_amount, :unit_price, :name

  before_save :calculate_total_amount

  def calculate_total_amount
    self.total_amount = self.shipped_quantity * self.unit_price
end
end
