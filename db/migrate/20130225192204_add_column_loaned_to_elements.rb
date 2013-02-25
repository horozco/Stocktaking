class AddColumnLoanedToElements < ActiveRecord::Migration
  def change
    add_column :elements, :loaned, :boolean, default: false
  end
end
