class AddNameToShipmentRows < ActiveRecord::Migration
  def change
    add_column :shipment_rows, :name, :string
  end
end
