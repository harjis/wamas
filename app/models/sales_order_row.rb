class SalesOrderRow < ActiveRecord::Base
  belongs_to :sales_order
  attr_accessible :discount_amount, :discount_percent, :line_amount, :name, :order_quantity, :row_number, :unit_cost, :unit_price
end
