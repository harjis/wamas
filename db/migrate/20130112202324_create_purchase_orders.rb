class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer :order_number
      t.boolean :completely_arrived
      t.boolean :completely_invoiced

      t.timestamps
    end
  end
end
