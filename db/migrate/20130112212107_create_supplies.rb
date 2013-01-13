class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.references :purchase_order
      t.string :name

      t.timestamps
    end
    add_index :supplies, :purchase_order_id
  end
end
