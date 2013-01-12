class SalesOrder < ActiveRecord::Base
  has_many :sales_order_rows, :dependent => :destroy
  attr_accessible :completely_delivered, :completely_invoiced, :order_number

  accepts_nested_attributes_for :sales_order_rows, :allow_destroy => true

  attr_accessible :sales_order_rows_attributes
end
