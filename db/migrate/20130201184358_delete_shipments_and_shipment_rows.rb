class DeleteShipmentsAndShipmentRows < ActiveRecord::Migration
  def up
    if table_exists? :shipments
      drop_table :shipments
    end

    if table_exists? :shipment_rows
      drop_table :shipment_rows
    end
  end

  def down
    if !table_exists? :shipments
      create_table :shipments
    end
    if !table_exists? :shipment_rows
      create_table :shipment_rows
    end
  end
end
