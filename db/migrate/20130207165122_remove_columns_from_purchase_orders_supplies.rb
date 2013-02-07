class RemoveColumnsFromPurchaseOrdersSupplies < ActiveRecord::Migration
  def up
    if column_exists? :purchase_orders_supplies, :id
      remove_column :purchase_orders_supplies, :id
    end
    if column_exists? :purchase_orders_supplies, :created_at
      remove_column :purchase_orders_supplies, :created_at
    end
    if column_exists? :purchase_orders_supplies, :updated_at
      remove_column :purchase_orders_supplies, :updated_at
    end
  end

  def down
    if !column_exists? :purchase_orders_supplies, :id
      add_column :purchase_orders_supplies, :id
    end
    if !column_exists? :purchase_orders_supplies, :created_at
      add_column :purchase_orders_supplies, :created_at
    end
    if !column_exists? :purchase_orders_supplies, :updated_at
      add_column :purchase_orders_supplies, :updated_at
    end
  end
end
