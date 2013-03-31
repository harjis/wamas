class Warehouse < ActiveRecord::Base
  has_many :warehouse_spots
  has_many :supplies
  has_many :shipments
  has_many :warehouse_inventories
  attr_accessible :main_warehouse, :name
end
