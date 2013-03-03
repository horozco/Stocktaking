class ChangeColumnsOnLoans < ActiveRecord::Migration
  def change
  	rename_column :loans, :loaned_by_id, :user_id
  	add_index :loans, :user_id
  	remove_column :loans, :time_loan
  end
end
