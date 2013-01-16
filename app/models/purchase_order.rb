class PurchaseOrder < ActiveRecord::Base
  has_many :purchase_order_rows, :dependent => :destroy
  has_and_belongs_to_many :supplies
  attr_accessible :completely_arrived, :completely_invoiced, :order_number

  accepts_nested_attributes_for :purchase_order_rows, :allow_destroy => true

  attr_accessible :purchase_order_rows_attributes
end
