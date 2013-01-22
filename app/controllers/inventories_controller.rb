class InventoriesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @inventory = Inventory.new()
  end

  def create
    @inventory = Inventory.new(params[:inventory])
    @inventory.user = current_user
    if @inventory.save
      redirect_to user_inventories_path(current_user), notice: "Inventory was created" 
    else
      flash[:alert] = "Inventory wasn't created :("
      render action: "new"
    end
  end

  def index
    if user_signed_in?
    @inventories = current_user.inventories.order("created_at DESC")
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
          format.html { redirect_to user_inventory_path(current_user) }
        end
    else
        flash[:alert] = "Inventory wasn't destroyed"
       respond_to do |format|
          format.html { redirect_to user_inventory_path(current_user) }
        end
    end
  end

end
