class Loan < ActiveRecord::Base
  belongs_to :element
  attr_accessible :time_loan, :loaned_to_id, :loaned_by_id
end
