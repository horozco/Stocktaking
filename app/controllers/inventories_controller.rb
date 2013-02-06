class InventoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @inventory = Inventory.new(params[:inventory])
    @inventory.user = current_user
    if @inventory.save
      redirect_to inventory_path(@inventory), notice: "El inventario se ha actualizado correctamente."
    else
      flash[:alert] = "Inventory wasn't created :("
      render action: "index"
    end
  end

  def index
    if user_signed_in?
      @inventories = current_user.inventories.order("created_at DESC")
      @inventory = Inventory.new()
    end
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update_attributes(params[:inventory])
      redirect_to @inventory, notice: "Inventory was updated" 
    else
      flash[:alert] = "Inventory wasn't updated :("
      render action: "edit"
    end
  end

  def destroy
  @inventory = Inventory.find(params[:id])
    if @inventory.destroy
        flash[:notice] = "Inventory was destroyed successfully"
        respond_to do |format|
          format.html { redirect_to inventories_path }
        end
    else
        flash[:alert] = "Inventory wasn't destroyed"
       respond_to do |format|
          format.html { redirect_to inventories_path }
        end
    end
  end

end
