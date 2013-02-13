class AddFullNameAndPhotoToUsers < ActiveRecord::Migration
  def self.up
  	add_attachment :users, :photo
  	add_column :users, :full_name, :string
  end
  def self.down
  	remove_attachment :users, :photo
  	remove_column :users, :full_name
  end
end
