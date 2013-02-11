class SalesOrderRow < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :product
  attr_accessible :discount_percent, :line_amount, :name, :order_quantity, :row_number, :unit_price, :product_id

  before_save :calculate_line_amount

  def calculate_line_amount
    if self.discount_percent.blank?
      self.discount_percent = 0
    end
    self.line_amount = (self.order_quantity * self.unit_price) * (1 - (self.discount_percent / 100))
  end
end
