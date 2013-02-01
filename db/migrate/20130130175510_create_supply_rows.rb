class CreateSupplyRows < ActiveRecord::Migration
  def change
    create_table :supply_rows do |t|
      t.references :supply
      t.integer :supply_row_number
      t.integer :supplied_quantity
      t.references :warehouse_entry
      t.float :unit_cost
      t.float :unit_cost_lcy
      t.float :total_amount
      t.float :total_amount_lcy

      t.timestamps
    end
    add_index :supply_rows, :supply_id
    add_index :supply_rows, :warehouse_entry_id
  end
end
