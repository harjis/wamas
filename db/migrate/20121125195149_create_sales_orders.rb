class CreateSalesOrders < ActiveRecord::Migration
  def change
    create_table :sales_orders do |t|
      t.integer :order_number
      t.boolean :completely_delivered
      t.boolean :completely_invoiced

      t.timestamps
    end
  end
end
