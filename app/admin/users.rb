ActiveAdmin.register User do
  index do
    column "Photo" do |user|
      link_to image_tag("/users/#{user.id}/tiny/#{user.photo_file_name}",
                           :alt => "photo"), admin_user_path(user)
    end
    column :full_name
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :full_name
  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :full_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :photo, :as => :file,
                       :hint => f.template.image_tag(f.object.photo.url(:preview))
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :full_name
      row :email
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row :photo do
        image_tag(user.photo.url(:preview))
      end
    end
    active_admin_comments
  end
=begin
  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end

      @user = user
      if @user.update_attributes(params[:user])
        set_flash_message :notice, :updated
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to after_update_path_for(@user)
      else
        render "edit"
      end
    end
  end
=end
end
