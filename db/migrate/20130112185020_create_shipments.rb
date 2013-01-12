class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.references :sales_order
      t.string :name

      t.timestamps
    end
    add_index :shipments, :sales_order_id
  end
end
