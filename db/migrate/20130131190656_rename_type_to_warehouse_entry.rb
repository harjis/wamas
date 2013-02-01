class RenameTypeToWarehouseEntry < ActiveRecord::Migration
  def up
    rename_column :warehouse_entries, :type, :entry_type
  end

  def down
    rename_column :warehouse_entries, :entry_type, :type
  end
end
