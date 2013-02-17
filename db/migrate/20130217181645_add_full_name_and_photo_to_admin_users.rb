class AddFullNameAndPhotoToAdminUsers < ActiveRecord::Migration
  def self.up
  	add_attachment :admin_users, :photo
  	add_column :admin_users, :full_name, :string
  end
  def self.down
  	remove_attachment :admin_users, :photo
  	remove_column :admin_users, :full_name
  end
end
