class SupplyRow < ActiveRecord::Base
  belongs_to :supply
  belongs_to :warehouse_entry
  belongs_to :purchase_order_row
  attr_accessible :purchase_order_row_id, :name, :supplied_quantity, :total_amount, :unit_cost

  before_save :calculate_total_amount

  def calculate_total_amount
    self.total_amount = self.supplied_quantity * self.unit_cost
  end
end
