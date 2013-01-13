class WarehouseSpot < ActiveRecord::Base
  belongs_to :warehouse
  has_many :warehouse_entry_spots
  attr_accessible :level, :position, :row, :warehouse_id

  def find_empty_spots_by_warehouse_id(warehouse_id)

    #NOT DONE

    #@warehouse_spots = WarehouseSpot.find_by_warehouse_id(warehouse_id)
    #
    #return_spots = Array.new
    #@warehouse_spots.each do |warehouse_spot|
    #  if warehouse_spot.warehouse_entry_spots.empty?
    #    return_spots push warehouse_spot
    #  else
    #    if warehouse_spot.warehouse_entry
    #  end
    #end

  end
end
