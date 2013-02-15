# encoding: utf-8
ActiveAdmin.register Inventory do
  index :title => "Inventarios" do
    column "Id", :id
    column "Lugar", :site
    column "Detalles", :details
    column "Fecha de creación", :created_at
    column "Fecha de actualización", :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :site
      row :details
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
