class Element < ActiveRecord::Base
  attr_accessible :details, :name, :reference, :status, :value, :inventory
  validates_presence_of :details, :name, :reference, :status, :value
  validates_uniqueness_of :reference
  belongs_to :inventory

  scope :by_inventory, lambda { |inventario| 
  	joins(:inventory).where(["inventories.id IN (?) ", inventario] ).uniq }
  	
end