class RemoveColumnsFromWarehouseEntries < ActiveRecord::Migration
  def up
    if column_exists? :warehouse_entries, :remaining_quantity
      remove_column :warehouse_entries, :remaining_quantity
    end
    if column_exists? :warehouse_entries, :unit_cost
      remove_column :warehouse_entries, :unit_cost
    end
  end

  def down
    if !column_exists? :warehouse_entries, :remaining_quantity
      add_column :warehouse_entries, :remaining_quantity
    end
    if !column_exists? :warehouse_entries, :unit_cost
      add_column :warehouse_entries, :unit_cost
    end
  end
end
