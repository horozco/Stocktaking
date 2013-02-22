class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :element
      t.datetime :time_loan
      t.references :loaned_to
      t.references :loaned_by

      t.timestamps
    end
    add_index :loans, :element_id
    add_index :loans, :loaned_to_id
    add_index :loans, :loaned_by_id
  end
end
