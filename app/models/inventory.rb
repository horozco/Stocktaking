class Inventory < ActiveRecord::Base
  attr_accessible :details, :site, :user_id
  validates_presence_of :details, :site
  belongs_to :user
  has_many :elements, dependent: :destroy
end
