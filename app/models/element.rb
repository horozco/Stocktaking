class Element < ActiveRecord::Base
  attr_accessible :details, :name, :reference, :status, :value, :inventory, :loaned
  validates_presence_of :details, :name, :reference, :status, :value
  validates_uniqueness_of :reference, :scope => :inventory_id
  belongs_to :inventory
  has_many :loans

  scope :by_inventory, lambda { |inventario|
  	joins(:inventory).where(["inventories.id IN (?) ", inventario] ).uniq }

  STATUSES = {:funcionando => "Funcionando", :funcionando_con_problemas => "Funcionando con problemas", :no_funciona => "No funciona"}
end