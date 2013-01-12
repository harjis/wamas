class Warehouse < ActiveRecord::Base
  has_many :warehouse_spots
  attr_accessible :main_warehouse, :name
end
