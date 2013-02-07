class RemoveRowNumberFromSalesOrderRows < ActiveRecord::Migration
  def up
    remove_column :sales_order_rows, :row_number
  end

  def down
    add_column :sales_order_rows, :row_number, :integer
  end
end
