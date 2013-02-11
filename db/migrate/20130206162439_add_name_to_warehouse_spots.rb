class AddNameToWarehouseSpots < ActiveRecord::Migration
  def change
    add_column :warehouse_spots, :name, :string
  end
end
