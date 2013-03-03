class AddNewColumnsToLoans < ActiveRecord::Migration
  def change
  	add_column :loans, :start_date, :datetime
  	add_column :loans, :end_date, :datetime
  	add_column :loans, :finished, :boolean, default: false
  end
end
