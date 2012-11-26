class Inventory < ActiveRecord::Base
  attr_accessible :details, :site
  validates_presence_of :details, :site
  has_many :elements
end
