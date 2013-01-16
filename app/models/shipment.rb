class Shipment < ActiveRecord::Base
  belongs_to :sales_order
  has_many :shipment_rows
  attr_accessible :name
end
