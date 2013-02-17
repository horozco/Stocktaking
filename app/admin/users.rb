# encoding: UTF-8
ActiveAdmin.register User, as: "Usuario" do
  
  menu parent: "Usuarios", priority: 1
  config.sort_order = "full_name_asc"
  config.per_page = 10

  index do
    selectable_column
    column :id
    column "Foto" do |user|
      link_to image_tag("/users/#{user.id}/tiny/#{user.photo_file_name}"), admin_usuario_path(user)
    end
    column "Nombre Completo", :full_name
    column "Correo Electrónico", :email
    column "Último Ingreso", :last_sign_in_at
    column "No de Ingresos", :sign_in_count
    column "Fecha de creación", :created_at
    default_actions
  end

  filter :full_name, :label => 'Nombre Completo'
  filter :email, :label => 'Correo Electrónico'

  form do |f|
    f.inputs "Detalle de usuario" do
      f.input :full_name, label:"Nombre Completo"
      f.input :email, label:"Correo Electrónico"
      f.input :password, label:"Contraseña"
      f.input :password_confirmation, label:"Confirme Contraseña"
      f.input :photo, label:"Foto ",:as => :file,
                       :hint => f.template.image_tag(f.object.photo.url(:preview))
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row "Nombre Completo" do
        usuario.full_name
      end
      row "Correo Electrónico" do
        usuario.email
      end
      row "Cantidad total de Ingresos" do
        usuario.sign_in_count
      end
      row "Última Fecha de Ingreso" do
        usuario.last_sign_in_at
      end
      row "Fecha de creación" do
        usuario.created_at
      end
      row "Fecha de actualización" do
        usuario.updated_at
      end
      row :photo do
        image_tag(usuario.photo.url(:preview))
      end
    end
    active_admin_comments
  end

  controller do
    def update
      if params[:usuario][:password].blank?
        params[:usuario].delete("password")
        params[:usuario].delete("password_confirmation")
      end

      @user = User.find(params[:id])
      if @user.update_attributes(params[:usuario])
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to admin_usuario_path(@user)
      else
        render "edit"
      end
    end
  end

  csv do
    column ("id") {|admin| admin.id}
    column ("Nombre Completo") {|admin| admin.full_name}
    column ("Email") {|admin| admin.email}
    column ("Último Ingreso") {|admin| admin.last_sign_in_at}
    column ("Cantidad de Ingresos") {|admin| admin.sign_in_count}
    column ("Fecha de creación") {|admin| admin.created_at}
    column ("Fecha de actualización") {|admin| admin.updated_at}
  end

  sidebar :Ayuda, :only => :edit do
    "Si no deseas cambiar la contraseña, no rellenes ninguno de los campos que se refieren a esta; si deseas cambiarla, debes confirmar la contraseña."
  end
  sidebar :Foto, :only => :edit do
    "La fotografía para el usuario no debe sobrepasar 10 megabytes, entre menor tamaño tenga mucho mejor."
  end
end
