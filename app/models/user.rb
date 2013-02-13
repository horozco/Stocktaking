class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :photo, :full_name
  #Relations
  has_many :inventories, dependent: :destroy

  has_attached_file :photo,
    :styles => {
      :tiny => "32x32!",
      :preview => "190x255!",
      :large => "300x300!"
    },
    :default_style => :large,
    :url => "/users/:id/:style/:basename.:extension",
    :path => ":rails_root/public/users/:id/:style/:basename.:extension",
    :default_url => "/images/missing/missing_:style.png"
  validates_attachment :photo,
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"]  },
  :size => { :less_than => 10.megabytes }
end
