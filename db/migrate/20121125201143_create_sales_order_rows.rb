class CreateSalesOrderRows < ActiveRecord::Migration
  def change
    create_table :sales_order_rows do |t|
      t.string :name
      t.integer :row_number
      t.integer :order_quantity
      t.float :unit_price
      t.float :discount_percent
      t.float :discount_amount
      t.float :line_amount
      t.float :unit_cost
      t.references :sales_order

      t.timestamps
    end
    add_index :sales_order_rows, :sales_order_id
  end
end
