class CreatePurchaseOrderRows < ActiveRecord::Migration
  def change
    create_table :purchase_order_rows do |t|
      t.string :name
      t.integer :row_number
      t.integer :order_quantity
      t.float :unit_cost
      t.float :line_amount
      t.references :purchase_order

      t.timestamps
    end
    add_index :purchase_order_rows, :purchase_order_id
  end
end
