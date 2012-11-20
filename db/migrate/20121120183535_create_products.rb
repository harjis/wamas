class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :date_created
      t.datetime :date_modified
      t.boolean :deleted
      t.text :description

      t.timestamps
    end
  end
end
