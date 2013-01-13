class Supply < ActiveRecord::Base
  belongs_to :purchase_order
  has_many :supply_rows
  attr_accessible :name
end
