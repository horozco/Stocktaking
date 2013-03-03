class Loan < ActiveRecord::Base
  belongs_to :element
  belongs_to :user
  belongs_to :loaned_to, :class_name => 'User'
  attr_accessible :loaned_to_id, :user_id, :element_id, :start_date, :end_date, :finished

  validates_presence_of :user_id, :loaned_to_id, :start_date, :element_id
end
