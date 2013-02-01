class RemoveNameFromSupply < ActiveRecord::Migration
  def up
  end

  def down
    remove_column :supplies, :name
  end
end
