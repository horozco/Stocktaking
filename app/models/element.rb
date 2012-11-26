class Element < ActiveRecord::Base
  attr_accessible :details, :name, :reference, :status, :value
  validates_presence_of :details, :name, :reference, :status, :value
  validates_uniqueness_of :reference
  belongs_to :inventory
end