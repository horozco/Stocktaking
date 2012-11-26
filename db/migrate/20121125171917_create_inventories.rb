class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :site
      t.text :details

      t.timestamps
    end
  end
end
