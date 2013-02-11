class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.references :sales_order
      t.references :warehouse

      t.timestamps
    end
    add_index :shipments, :sales_order_id
    add_index :shipments, :warehouse_id
  end
end
