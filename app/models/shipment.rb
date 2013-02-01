class Shipment < ActiveRecord::Base
  belongs_to :sales_order
  has_many :shipment_rows
  belongs_to :warehouse

  accepts_nested_attributes_for :shipment_rows, :allow_destroy => true

  attr_accessible :shipment_rows, :warehouse
end
