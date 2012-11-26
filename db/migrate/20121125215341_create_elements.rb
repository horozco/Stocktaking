class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.string :reference
      t.string :status
      t.float :value
      t.text :details
      t.references :inventory

      t.timestamps
    end
    add_index :elements, :inventory_id
  end
end
