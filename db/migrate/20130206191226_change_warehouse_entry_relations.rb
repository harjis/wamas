class ChangeWarehouseEntryRelations < ActiveRecord::Migration
  def up
    if column_exists? :warehouse_entry_spots, :warehouse_entry_id
      remove_column :warehouse_entry_spots, :warehouse_entry_id
    end

    create_table :warehouse_entries_warehouse_entry_spots, :id => false do |t|
      t.references :warehouse_entry
      t.references :warehouse_entry_spot
    end

    add_index :warehouse_entries_warehouse_entry_spots, :warehouse_entry_id, :name => 'index_warehouse_entry_link_on_warehouse_entry_id'
    add_index :warehouse_entries_warehouse_entry_spots, :warehouse_entry_spot_id, :name => 'index_warehouse_entry_link_on_warehouse_spot_id'
  end

  def down
    add_column :warehouse_entry_spots, :warehouse_entry_id, :integer

    if table_exists? :warehouse_entries_warehouse_entry_spots
      drop_table :warehouse_entries_warehouse_entry_spots
    end
  end
end
