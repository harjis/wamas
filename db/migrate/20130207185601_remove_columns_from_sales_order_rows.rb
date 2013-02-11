class RemoveColumnsFromSalesOrderRows < ActiveRecord::Migration
  def up
    remove_column :sales_order_rows, :discount_amount
    remove_column :sales_order_rows, :unit_cost
  end

  def down
    add_column :sales_order_rows, :unit_cost, :float
    add_column :sales_order_rows, :discount_amount, :float
  end
end
