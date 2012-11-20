class Product < ActiveRecord::Base
  attr_accessible :date_created, :date_modified, :deleted, :description, :name
end
