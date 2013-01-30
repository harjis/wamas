# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130130175522) do

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "date_created"
    t.datetime "date_modified"
    t.boolean  "deleted"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "purchase_order_rows", :force => true do |t|
    t.string   "name"
    t.integer  "row_number"
    t.integer  "order_quantity"
    t.float    "unit_cost"
    t.float    "line_amount"
    t.integer  "purchase_order_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "product_id"
  end

  add_index "purchase_order_rows", ["purchase_order_id"], :name => "index_purchase_order_rows_on_purchase_order_id"

  create_table "purchase_orders", :force => true do |t|
    t.integer  "order_number"
    t.boolean  "completely_arrived"
    t.boolean  "completely_invoiced"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "purchase_orders_supplies", :force => true do |t|
    t.integer  "purchase_order_id"
    t.integer  "supply_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "purchase_orders_supplies", ["purchase_order_id"], :name => "index_purchase_orders_supplies_on_purchase_order_id"
  add_index "purchase_orders_supplies", ["supply_id"], :name => "index_purchase_orders_supplies_on_supply_id"

  create_table "sales_order_rows", :force => true do |t|
    t.string   "name"
    t.integer  "row_number"
    t.integer  "order_quantity"
    t.float    "unit_price"
    t.float    "discount_percent"
    t.float    "discount_amount"
    t.float    "line_amount"
    t.float    "unit_cost"
    t.integer  "sales_order_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "product_id"
  end

  add_index "sales_order_rows", ["sales_order_id"], :name => "index_sales_order_rows_on_sales_order_id"

  create_table "sales_orders", :force => true do |t|
    t.integer  "order_number"
    t.boolean  "completely_delivered"
    t.boolean  "completely_invoiced"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "shipment_rows", :force => true do |t|
    t.integer  "shipment_id"
    t.integer  "shipment_row_number"
    t.integer  "shipped_quantity"
    t.integer  "warehouse_entry_id"
    t.float    "unit_price"
    t.float    "unit_price_lcy"
    t.float    "discount_percent"
    t.float    "discount_amount"
    t.float    "discount_amount_lcy"
    t.float    "total_amount"
    t.float    "total_amount_lcy"
    t.float    "unit_cost"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "shipment_rows", ["shipment_id"], :name => "index_shipment_rows_on_shipment_id"
  add_index "shipment_rows", ["warehouse_entry_id"], :name => "index_shipment_rows_on_warehouse_entry_id"

  create_table "shipments", :force => true do |t|
    t.integer  "sales_order_id"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "shipments", ["sales_order_id"], :name => "index_shipments_on_sales_order_id"

  create_table "supplies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supply_rows", :force => true do |t|
    t.integer  "supply_id"
    t.integer  "supply_row_number"
    t.integer  "supplied_quantity"
    t.integer  "warehouse_entry_id"
    t.float    "unit_cost"
    t.float    "unit_cost_lcy"
    t.float    "total_amount"
    t.float    "total_amount_lcy"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "supply_rows", ["supply_id"], :name => "index_supply_rows_on_supply_id"
  add_index "supply_rows", ["warehouse_entry_id"], :name => "index_supply_rows_on_warehouse_entry_id"

  create_table "warehouse_entries", :force => true do |t|
    t.integer  "product_id"
    t.string   "type"
    t.integer  "quantity"
    t.integer  "remaining_quantity"
    t.float    "unit_cost"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "warehouse_entries", ["product_id"], :name => "index_warehouse_entries_on_product_id"

  create_table "warehouse_entry_spots", :force => true do |t|
    t.integer  "warehouse_entry_id"
    t.integer  "warehouse_spot_id"
    t.float    "spot_weight"
    t.integer  "spot_quantity"
    t.integer  "remaining_spot_quantity"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "warehouse_entry_spots", ["warehouse_entry_id"], :name => "index_warehouse_entry_spots_on_warehouse_entry_id"
  add_index "warehouse_entry_spots", ["warehouse_spot_id"], :name => "index_warehouse_entry_spots_on_warehouse_spot_id"

  create_table "warehouse_spots", :force => true do |t|
    t.integer  "warehouse_id"
    t.string   "row"
    t.integer  "level"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "warehouse_spots", ["warehouse_id"], :name => "index_warehouse_spots_on_warehouse_id"

  create_table "warehouses", :force => true do |t|
    t.string   "name"
    t.boolean  "main_warehouse"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
