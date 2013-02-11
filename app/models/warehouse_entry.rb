class WarehouseEntry < ActiveRecord::Base
  belongs_to :product
  has_one :shipment_row
  has_and_belongs_to_many :warehouse_entry_spots
  attr_accessible :quantity, :entry_type, :warehouse_entry_id, :warehouse_entry_spots

  def populate_by_shipment_or_supply(row)
    if !row.blank?
      if row.instance_of? SupplyRow
        if !row.supplied_quantity.blank?
          self.quantity = row.supplied_quantity
        end
        if !row.purchase_order_row.product_id.blank?
          self.product_id = row.purchase_order_row.product.id
        end
        self.entry_type = 'supply'
      elsif row.instance_of? ShipmentRow
        if !row.shipped_quantity.blank?
          self.quantity = row.shipped_quantity
        end
        if !row.sales_order_row.product_id.blank?
          self.product_id = row.sales_order_row.product.id
        end
        self.entry_type = 'shipment'
      end
    end
  end
end
