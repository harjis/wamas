class AddProductIdToSalesOrderRow < ActiveRecord::Migration
  def change
    add_column :sales_order_rows, :product_id, :integer
  end
end
