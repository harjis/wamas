class RenameTypeToWarehouseEntry < ActiveRecord::Migration
  def up
    rename_column :warehouse_entries, :type, :entry_type
  end

  def down
  end
end
