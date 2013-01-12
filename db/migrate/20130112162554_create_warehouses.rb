class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :name
      t.boolean :main_warehouse

      t.timestamps
    end
  end
end
