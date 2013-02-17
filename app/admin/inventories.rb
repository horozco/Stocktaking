# encoding: utf-8
ActiveAdmin.register Inventory, as: "Inventario" do
  
  menu :priority => 1
  config.sort_order = "site_asc"
  config.per_page = 10

  scope "Todos", :all, :default => true
  scope "Finalizados", :finished
  scope "Sin finalizar", :unfinished

  index do
    selectable_column
    column "Id", :id
    column "Lugar", :site
    column "Detalles", :details
    column "Usuario", :user
    column "Fecha de creación", :created_at
    column "Fecha de actualización", :updated_at
    column "Finalizado" do |inventory|
      inventory.finished ? "Si" : "No" 
    end
    default_actions
  end

  filter :user, :label => 'Usuario'
  filter :site, :label => 'Lugar'
  filter :created_at, as: :date_range, label: "Fecha de creación"
  filter :updated_at, as: :date_range, label: "Fecha de actualización"

  show do
    
    attributes_table do
      row :id
      row "Lugar" do
        inventario.site
      end
      row "Detalles" do
        inventario.details
      end
      row "Fecha de creación" do
        inventario.created_at
      end
      row "Fecha de actualización" do
        inventario.updated_at
      end
      row "Finalizado?" do
        inventario.finished ? "Si" : "No"
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Detalle de Inventario" do
      f.input :user, label:"Usuario"
      f.input :site, label:"Lugar"
      f.input :details, label:"Detalles"
    end
    f.actions
  end

  csv do
    column :id
    column ("Lugar") { |inventory| inventory.site }
    column("Usuario") { |inventory| inventory.user.full_name }
    column ("Detalles") { |inventory| inventory.details }
    column ("Fecha de creación") { |inventory| inventory.created_at }
    column ("Fecha de actualización") { |inventory| inventory.updated_at }
    column ("Finalizado") { |inventory| inventory.finished ? "Si" : "No" }
  end

end
