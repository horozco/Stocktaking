class AddStatusToInventories < ActiveRecord::Migration
  def self.up
  	add_column :inventories, :finished, :boolean, :default => false
  end
  def self.down
  	remove_column :inventories, :finished
  end
end
