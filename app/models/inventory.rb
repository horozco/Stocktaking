class Inventory < ActiveRecord::Base
  attr_accessible :details, :site
  validates_presence_of :details, :site
  belongs_to :user, dependent: :destroy
  has_many :elements
end
