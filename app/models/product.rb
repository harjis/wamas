class Product < ActiveRecord::Base
  has_many :sales_order_rows
  has_many :warehouse_entries
  attr_accessible :date_created, :date_modified, :deleted, :description, :name
end
