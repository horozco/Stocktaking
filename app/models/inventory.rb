class Inventory < ActiveRecord::Base
  attr_accessible :details, :site, :user_id, :finished
  validates_presence_of :details, :site, :user
  belongs_to :user
  has_many :elements, dependent: :destroy

  scope :finished, where(["finished = ?", true])
  scope :unfinished, where(["finished = ?", false])

end
