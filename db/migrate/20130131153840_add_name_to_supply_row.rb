class AddNameToSupplyRow < ActiveRecord::Migration
  def change
    add_column :supply_rows, :name, :string
  end
end
