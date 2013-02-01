class CreatePurchaseOrdersSupplies < ActiveRecord::Migration
  def up
    create_table :purchase_orders_supplies do |t|
      t.references :purchase_order
      t.references :supply

      t.timestamps
    end
    add_index :purchase_orders_supplies, :purchase_order_id
    add_index :purchase_orders_supplies, :supply_id
  end

  def down
  end
end