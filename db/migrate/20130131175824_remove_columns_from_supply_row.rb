class RemoveColumnsFromSupplyRow < ActiveRecord::Migration
  def up
    remove_column :supply_rows, :supply_row_number
    remove_column :supply_rows, :unit_cost_lcy
    remove_column :supply_rows, :total_amount_lcy
  end

  def down
    add_column :supply_rows, :total_amount_lcy, :float
    add_column :supply_rows, :unit_cost_lcy, :float
    add_column :supply_rows, :supply_row_number, :integer
  end
end
