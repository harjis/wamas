class AddPurchaseOrderRowIdToSupplyRow < ActiveRecord::Migration
  def change
    add_column :supply_rows, :purchase_order_row_id, :integer
  end
end
