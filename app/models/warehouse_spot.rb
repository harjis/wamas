class WarehouseSpot < ActiveRecord::Base
  belongs_to :warehouse
  has_many :warehouse_entry_spots
  attr_accessible :level, :position, :row, :warehouse_id, :name

  before_save :generate_name

  def generate_name
    self.name = "#{self.row}-#{self.level}-#{self.position}"
  end
end
