class RemoveRowNumberFromPurchaseOrderRows < ActiveRecord::Migration
  def up
    remove_column :purchase_order_rows, :row_number
  end

  def down
    add_column :purchase_order_rows, :row_number, :integer
  end
end
