class Loan < ActiveRecord::Base
  belongs_to :element
  belongs_to :user
  belongs_to :loaned_to, :class_name => 'User'
  attr_accessible :loaned_to_id, :user_id, :element_id, :start_date, :end_date, :finished

  validates_presence_of :user, :loaned_to, :start_date, :element

  scope :finished, where(["finished = ?", true])
  scope :unfinished, where(["finished = ?", false])

end
