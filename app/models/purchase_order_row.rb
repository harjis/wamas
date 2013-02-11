class PurchaseOrderRow < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :product
  has_many :supply_rows
  attr_accessible :line_amount, :name, :order_quantity, :row_number, :unit_cost, :product_id

  before_save :calculate_line_amount

  def calculate_line_amount
    self.line_amount = self.unit_cost * self.order_quantity
  end
end
