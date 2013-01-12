class CreateWarehouseEntries < ActiveRecord::Migration
  def change
    create_table :warehouse_entries do |t|
      t.references :product
      t.string :type
      t.integer :quantity
      t.integer :remaining_quantity
      t.float :unit_cost

      t.timestamps
    end
    add_index :warehouse_entries, :product_id
  end
end
