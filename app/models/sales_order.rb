class SalesOrder < ActiveRecord::Base
  has_many :sales_order_rows
  attr_accessible :completely_delivered, :completely_invoiced, :order_number
end
