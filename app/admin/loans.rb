# encoding: utf-8
ActiveAdmin.register Loan, as: "Prestamo" do
  
  config.sort_order = "created_at_asc"
  config.per_page = 20

  scope "Todos", :all, :default => true
  scope "Finalizados", :finished
  scope "Sin finalizar", :unfinished

  index do
    selectable_column
    column "Id", :id
    column "Prestado por", :user
    column "Prestado a", :loaned_to
    column "Fecha de inicio", :start_date
    column "Fecha de finalización", :end_date
    column "Fecha de creación", :created_at
    column "Fecha de actualización", :updated_at
    column "Finalizado" do |loan|
      loan.finished ? "Si" : "No" 
    end
    default_actions
  end

  filter :element, :label => 'Elemento'
  filter :user, :label => 'Prestado por'
  filter :loaned_to, :label => 'Prestado a'
  filter :start_date, as: :date_range, label: "Inicio del préstamo"
  filter :end_date, as: :date_range, label: "Finalización del préstamo"
  filter :created_at, as: :date_range, label: "Fecha de creación"
  filter :updated_at, as: :date_range, label: "Fecha de actualización"
  filter :finished, :label => 'Finalizado'

  show do
    attributes_table do
      row :id
      row "Elemento" do
        prestamo.element
      end
      row "Prestado a" do
        prestamo.user
      end
      row "Prestado por" do
        prestamo.loaned_to
      end
      row "Fecha de inicio" do
        prestamo.start_date
      end
      row "Fecha de finalización" do
        prestamo.end_date
      end
      row "Fecha de creación" do
        prestamo.created_at
      end
      row "Fecha de actualización" do
        prestamo.updated_at
      end
      row "Finalizado?" do
        prestamo.finished ? "Si" : "No"
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Detalle de Prestamo" do
      f.input :element, label:"Elemento"
      f.input :user, label:"Prestado por"
      f.input :loaned_to, label:"Prestado a"
      f.input :start_date, label:"Fecha de inicio"
      f.input :end_date, label:"Fecha de finalización"
      f.input :finished, label:"Finalizado"
    end
    f.actions
  end

  csv do
    column :id
    column ("Elemento") { |prestamo| prestamo.element.name }
    column ("Prestado por") { |prestamo| prestamo.user.full_name }
    column("Prestado a") { |prestamo| prestamo.loaned_to.full_name }
    column ("Fecha de inicio") { |prestamo| prestamo.start_date.localtime }
    column ("Fecha de finalización") { |prestamo| prestamo.end_date.localtime }
    column ("Fecha de creación") { |prestamo| prestamo.created_at.localtime }
    column ("Fecha de actualización") { |prestamo| prestamo.updated_at.localtime }
    column ("Finalizado") { |prestamo| prestamo.finished ? "Si" : "No" }
  end

end

