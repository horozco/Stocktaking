# encoding: utf-8
ActiveAdmin.register Element, as: "Elemento" do
  config.sort_order = "inventory_id_asc"
  config.per_page = 10

  scope "Todos", :all, :default => true
  scope "Prestados", :loaned
  scope "No Prestados", :not_loaned
=begin
  Inventory.all.each do |inventario|
  	scope "#{inventario.site}", :by_inventory do |algo| 
  		algo.by_inventory(inventario.id)
  	end
  end
=end
  index do
    selectable_column
    column "Inventario", :sortable => :inventory_id do |element|
    	link_to element.inventory.site, admin_inventario_path(element.inventory)
    end
    column "Id", :id
    column "Nombre", :name
    column "Referencia", :reference
    column "Estado", :status
    column "Valor", :value
    column "Detalles", :details
    column "Fecha de creación", :created_at
    column "Fecha de actualización", :updated_at
    default_actions
  end

  filter :inventory_id, :label => 'Inventario', :collection =>  Inventory.all.map{|inventory| [inventory.site, inventory.id]}
  filter :name, :label => 'Nombre'
  filter :reference, :label => 'Referencia'
  filter :status, :label => 'Estado'
  filter :value, as: :numeric, :label => 'Valor estimado'
  filter :created_at, as: :date_range, label: "Fecha de creación"
  filter :updated_at, as: :date_range, label: "Fecha de actualización"

  show do

    attributes_table do
      row :id
      row "Inventario" do
        link_to elemento.inventory.site, admin_inventario_path(elemento.inventory)
      end
      row "Usuario" do
        link_to elemento.inventory.user.full_name, admin_usuario_path(elemento.inventory.user)
      end
      row "Nombre" do
        elemento.name
      end
      row "Referencia" do
        elemento.reference
      end
      row "Estado" do
        elemento.status.humanize
      end
      row "Valor Estimado" do
        elemento.value
      end
      row "Detalles" do
        elemento.details
      end
      row "Prestado?" do
        elemento.loaned ? "Sí" : "No"
      end
      row "Fecha de creación" do
        elemento.created_at.localtime
      end
      row "Fecha de actualización" do
        elemento.updated_at.localtime
      end
    end

    div do
      panel("Préstamos del elemento") do
        table_for(elemento.loans) do
          column ("Prestado por") { |loan| link_to loan.user.full_name, admin_usuario_path(loan.user) }
          column ("Prestado a") { |loan| link_to loan.loaned_to.full_name, admin_usuario_path(loan.loaned_to) }
          column ("Fecha de inicio") { |loan| loan.start_date.localtime }
          column ("Fecha de finalización") { |loan| loan.end_date ? loan.end_date.localtime : "N/A"}
          column ("Finalizado") { |loan| loan.finished ? "Si" : "No"}
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Detalle de Inventario" do
      f.input :inventory, label:"Inventario", :collection =>  Inventory.all.map{|inventory| [inventory.site, inventory.id]}
      f.input :name, label:"Nombre"
      f.input :reference, label:"Referencia"
      f.input :status, label:"Estado"
      f.input :value, label:"Valor"
      f.input :details, label:"Detalles"
    end
    f.actions
  end

  csv do
    column :id
    column ("Inventario") { |element| element.inventory.site }
    column ("Nombre") { |element| element.name }
    column ("Referencia") { |element| element.reference }
    column ("Estado") { |element| element.status }
    column ("Valor Estimado") { |element| element.value }
    column ("Detalles") { |element| element.details }
    column ("Fecha de creación") { |element| element.created_at.localtime }
    column ("Fecha de actualización") { |element| element.updated_at.localtime }
  end
end