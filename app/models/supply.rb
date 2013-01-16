class Supply < ActiveRecord::Base
  has_and_belongs_to_many :purchase_orders
  attr_accessible :name
end
