class InventoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @inventory = Inventory.new(params[:inventory])
    @inventory.user = current_user
    if @inventory.save
      redirect_to inventory_path(@inventory), notice: "El inventario se ha creado correctamente."
    else
      flash[:alert] = "No se pudo crear el inventario."
      redirect_to inventories_path
    end
  end

  def index
    @inventories = current_user.inventories.order("created_at DESC")
    @inventory = Inventory.new()
    $path = request.fullpath
  end

  def show
    @inventory = Inventory.find(params[:id])
    $path = request.fullpath
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update_attributes(params[:inventory])
      flash[:notice] = "El inventario se ha actualizado correctamente."
      if $path == "/inventories"
        redirect_to inventories_path  
      else
        redirect_to @inventory
      end
    else
      flash[:alert] = "No se pudo actualizar el inventario."
      if $path == "/inventories"
        redirect_to inventories_path
      else
        redirect_to @inventory
      end
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.destroy
      flash[:notice] = "Se ha destruido el inventario correctamente."
      redirect_to inventories_path
    else
      flash[:alert] = "No se ha podido eliminar el inventario."
      redirect_to inventories_path
    end
  end
end
