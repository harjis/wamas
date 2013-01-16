class CreateShipmentRows < ActiveRecord::Migration
  def change
    create_table :shipment_rows do |t|
      t.references :shipment
      t.integer :shipment_row_number
      t.integer :shipped_quantity
      t.references :warehouse_entry
      t.float :unit_price
      t.float :unit_price_lcy
      t.float :discount_percent
      t.float :discount_amount
      t.float :discount_amount_lcy
      t.float :total_amount
      t.float :total_amount_lcy
      t.float :unit_cost

      t.timestamps
    end
    add_index :shipment_rows, :shipment_id
    add_index :shipment_rows, :warehouse_entry_id
  end
end
