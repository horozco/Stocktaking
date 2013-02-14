# encoding: UTF-8
ActiveAdmin.register AdminUser do
  index :title => "Usuarios Administradores" do
    column "Correo Electrónico", :email
    column "Último Ingreso", :last_sign_in_at
    column "Cantidad total de Ingresos", :sign_in_count
    column "Fecha de creación", :created_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Detalles de Administrador" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show :title => "Administrador" do
    attributes_table do
      row :id
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
    end
    active_admin_comments
  end

  controller do
    def update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end

      @user = AdminUser.find(params[:id])
      if @user.update_attributes(params[:admin_user])
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to admin_admin_user_path(@user)
      else
        render "edit"
      end
    end
  end
end
