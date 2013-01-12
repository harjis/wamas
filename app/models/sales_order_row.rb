class SalesOrderRow < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :product
  attr_accessible :discount_amount, :discount_percent, :line_amount, :name, :order_quantity, :row_number, :unit_cost, :unit_price, :product_id
end
