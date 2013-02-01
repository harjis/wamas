class Warehouse < ActiveRecord::Base
  has_many :warehouse_spots
  has_many :supplies
  attr_accessible :main_warehouse, :name
end
