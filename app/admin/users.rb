# encoding: UTF-8
ActiveAdmin.register User do
  index :title => "Usuarios" do
    column "Foto" do |user|
      link_to image_tag("/users/#{user.id}/tiny/#{user.photo_file_name}",
                           :alt => "photo"), admin_user_path(user)
    end
    column "Nombre Completo", :full_name
    column "Correo Electrónico", :email
    column "Último Ingreso", :last_sign_in_at
    column "Cantidad total de Ingresos", :sign_in_count
    column "Fecha de creación", :created_at
    default_actions
  end

  filter :full_name
  filter :email

  form do |f|
    f.inputs "Detalle de usuario" do
      f.input :full_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :photo, :as => :file,
                       :hint => f.template.image_tag(f.object.photo.url(:preview))
    end
    f.actions
  end

  show :title => "Usuario" do
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

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end

      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to admin_user_path(@user)
      else
        render "edit"
      end
    end
  end
end
