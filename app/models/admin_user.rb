class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :photo

  has_attached_file :photo,
    :styles => {
      :tiny => "32x32!",
      :preview => "190x255!",
      :large => "300x300!"
    },
    :default_style => :large,
    :url => "/users/admins/:id/:style/:basename.:extension",
    :path => ":rails_root/public/users/admins/:id/:style/:basename.:extension",
    :default_url => "/images/missing/missing_:style.png"
  validates_attachment :photo,
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"]  },
  :size => { :less_than => 10.megabytes }

  validates_presence_of :full_name
end
