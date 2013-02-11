class Supply < ActiveRecord::Base
  has_and_belongs_to_many :purchase_orders
  has_many :supply_rows
  belongs_to :warehouse
  accepts_nested_attributes_for :supply_rows, :allow_destroy => true

  attr_accessible :supply_rows_attributes, :warehouse
end
