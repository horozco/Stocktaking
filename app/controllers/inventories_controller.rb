class InventoriesController < ApplicationController

  def new
    @inventory = Inventory.new()
  end

  def create
    @inventory = Inventory.new(params[:inventory])
    if @inventory.save
      redirect_to @inventory, notice: "Inventory was created" 
    else
      flash[:alert] = "Inventory wasn't created :("
      render action: "new"
    end
  end

  def index
    @inventories = Inventory.order("created_at DESC")
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
          format.html { redirect_to feed_url }
        end
    else
        flash[:alert] = "Inventory wasn't destroyed"
       respond_to do |format|
          format.html { redirect_to feed_url }
        end
    end
  end

end
