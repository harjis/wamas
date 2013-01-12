class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  attr_accessible :quantity, :remaining_quantity, :type, :unit_cost
end
