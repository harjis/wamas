class AddProductIdToPurchaseOrderRow < ActiveRecord::Migration
  def change
    add_column :purchase_order_rows, :product_id, :integer
  end
end
