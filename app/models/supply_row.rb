class SupplyRow < ActiveRecord::Base
  belongs_to :supply
  belongs_to :warehouse_entry
  belongs_to :purchase_order_row
  attr_accessible :supplied_quantity, :supply_row_number, :total_amount, :total_amount_lcy, :unit_cost, :unit_cost_lcy
end
