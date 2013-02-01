class CreateShipmentRows < ActiveRecord::Migration
  def change
    create_table :shipment_rows do |t|
      t.references :shipment
      t.references :sales_order_row
      t.references :warehouse_entry
      t.integer :shipped_quantity
      t.float :unit_price
      t.float :total_amount

      t.timestamps
    end
    add_index :shipment_rows, :shipment_id
    add_index :shipment_rows, :sales_order_row_id
    add_index :shipment_rows, :warehouse_entry_id
  end
end
